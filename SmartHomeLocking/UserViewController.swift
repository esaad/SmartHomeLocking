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
    @IBOutlet weak var listdevices: UILabel!
    
    var cManager = CBCentralManager()
    var discoveredPeripheral = CBPeripheral()
    
    var bluetoothOn = false
    
//func verboseMode -> Bool {return self.verbositySelector.selectedSegmentIndex!=0}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            bluetoothOn = false
        cManager = CBCentralManager(delegate: self, queue: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
        
        listdevices.text = "\(advertisementData)" + "\(RSSI)"
        self.discoveredPeripheral = peripheral
        
          
    }
    

    @IBAction func scanble(sender: AnyObject) {
        
        if (bluetoothOn == true) {
        cManager.scanForPeripheralsWithServices(nil , options: nil)
    }
        else {
        
        println("bluetooth is off")
        }}
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }

    @IBAction func logoutBtnClick(sender: AnyObject) {
        
        PFUser.logOut()
        //self.navigationController?.popToRootViewControllerAnimated(true)
        
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("root") as UIViewController, animated: true)
        
    }

}
