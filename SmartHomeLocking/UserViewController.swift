//
//  UserViewController.swift
//  SmartHomeLocking
//
//  Created by Muhammad Afaque on 2015-02-23.
//  Copyright (c) 2015 Esaad Afaque. All rights reserved.
//

import UIKit
import CoreBluetooth


class UserViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    let PositionCharUUID = "FFE1"
    let BLEServiceUUID = "FFE0"
    
    
    @IBOutlet weak var verbositySelector: UISegmentedControl!
    
    // @IBOutlet weak var stateLabel: UILabel!
    //@IBOutlet weak var listdevices: UILabel!
    
    
    @IBOutlet weak var stateLabel: UILabel!
    
    //   @IBOutlet weak var listBLE: UITableView!
    
    @IBOutlet weak var listDevice: UILabel!
    
    var cManager:CBCentralManager!
    var discoveredPeripheral:CBPeripheral!
    var test = false
    var bluetoothOn = false
    var positionCharacteristic: CBCharacteristic?
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
    
    
    @IBOutlet weak var connectDevice: UIButton!
    @IBAction func connectDeviceClick(sender: UIButton!) {
        if (test == true) {
            self.performSegueWithIdentifier("ControlCenter", sender: self)
            return
        }
        else {
            println("no connection")
            return
        }
        
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        
        // listDevice.text = "Discovered \(advertisementData.description) " + "\(RSSI.description)"
        
        listDevice.text = peripheral.name
        stateLabel.text = "\(peripheral.readRSSI())"
        discoveredPeripheral = peripheral
        
        
        
        if (self.verbositySelector.selectedSegmentIndex == 0) {
            println("inside 1")
            cManager.connectPeripheral(peripheral, options: nil)
            println("This is peripheral \(peripheral) " )
            test = true
        }
        
    }
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        
        
        
    }
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        if ((error) != nil) {
            println("error in discovery services")
            return
        }
        
        let services = peripheral.services as [CBService]
        
        for s in services {
            
            peripheral.discoverCharacteristics(nil, forService: s)
            
        }
        
    }
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        
        if ((error) != nil) {
            
            println("error in didDisconverCharac")
            return
        }
        
        let characteristic = service.characteristics
        
        /* come */
        
//        if service.UUID == PositionCharUUID {
//            self.positionCharacteristic = (characteristic as CBCharacteristic)
//            peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
//            
//        }
//    
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