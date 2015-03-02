//
//  UserViewController.swift
//  SmartHomeLocking
//
//  Created by Muhammad Afaque on 2015-02-23.
//  Copyright (c) 2015 Esaad Afaque. All rights reserved.
//

import UIKit


class UserViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate{

    @IBOutlet weak var verbositySelector: UISegmentedControl!
    
    @IBOutlet weak var valueLabel: UILabel!
   // @IBOutlet weak var listdevices: UILabel!
    
    
    @IBOutlet weak var listDevice: UILabel!
    
    var cManager:CBCentralManager!
    var discoveredPeripheral:CBPeripheral!
    
    var bluetoothOn = false
    
//    func verboseMode()
//    
//    {
//    
//        return self.verbositySelector.selectedSegmentIndex
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            bluetoothOn = false
        self.cManager = CBCentralManager(delegate: self, queue: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func scanble(sender: AnyObject) {
        
        if (bluetoothOn == true) {
            println("scan button pressed")
            if (cManager.state == CBCentralManagerState.PoweredOn) {
                cManager.scanForPeripheralsWithServices(nil , options: [CBCentralManagerScanOptionAllowDuplicatesKey:false])
                println("inside scan")
            }
        }
        else {
            
            println("bluetooth is off")
        }}


    func centralManagerDidUpdateState(central: CBCentralManager!) {
        if central.state != CBCentralManagerState.PoweredOn {
            
            println("BLUETOOTH OFF")
            self.bluetoothOn = false
        }
        else {
            println("BLUETOOTH ON")
            self.bluetoothOn = true
            
        }
    }
    
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        
        listDevice.text = "Discovered \(advertisementData.description)" + "\(RSSI.description)"
      discoveredPeripheral = peripheral
        println("This is peripheral \(peripheral) " )
        
        
        if (self.verbositySelector.selectedSegmentIndex == 0) {
            println("inside 1")
            cManager.connectPeripheral(peripheral, options: nil)
        }
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        
        peripheral.delegate = self
        
    }

    @IBAction func logoutBtnClick(sender: AnyObject) {
        
        PFUser.logOut()
        //self.navigationController?.popToRootViewControllerAnimated(true)
        
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("root") as UIViewController, animated: true)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }

}
