//
//  ControlCenterController.swift
//  SmartHomeLocking
//
//  Created by Muhammad Afaque on 2015-03-03.
//  Copyright (c) 2015 Esaad Afaque. All rights reserved.
//

import UIKit
import CoreBluetooth


class ControlCenterController: UserViewController  {

    var timerTXDelay: NSTimer?
    var allowTX = true
    var lastPosition: UInt8 = 255
       
    func timerTXDelayElapsed() {
        self.allowTX = true
        self.stopTimerTXDelay()
        
        // Send current slider position
       // self.sendPosition(UInt8(self.positionSlider.value))
    }
    
    func stopTimerTXDelay() {
        if self.timerTXDelay == nil {
            return
        }
        
        timerTXDelay?.invalidate()
        self.timerTXDelay = nil
    }
    
    // Valid position range: 0 to 180
    func sendPosition(position: UInt8) {
        
        println("inside sendPOstinon")
        // 1
        if !allowTX {
            return
        }
        
        // 2
        // Validate value
        if position == lastPosition {
            return
        }
            // 3
        else if ((position < 0) || (position > 180)) {
            return
        }
        
        // 4
        // Send position to BLE Shield (if service exists and is connected)
       
            writePosition(position)
            println("ran writePostion")
            lastPosition = position
            
            // 5
            // Start delay timer
            allowTX = false
            if timerTXDelay == nil {
                timerTXDelay = NSTimer.scheduledTimerWithTimeInterval(0.1,
                    target: self,
                    selector: Selector("timerTXDelayElapsed"),
                    userInfo: nil,
                    repeats: false)
            }
        
    }
    
    
//    func writePosition(position: UInt8) {
//        // See if characteristic has been discovered before writing to it
//        if  positionCharacteristic == nil {
//            println("position characteristic is nil \(positionCharacteristic)")
//            return
//        }
//        
//        // Need a mutable var to pass to writeValue function
//        var positionValue = position
//        let data = NSData(bytes: &positionValue, length: sizeof(UInt8))
//        discoveredPeripheral.writeValue(data, forCharacteristic: positionCharacteristic, type: CBCharacteristicWriteType.WithoutResponse)
//        println("inside write position2 --->  \(positionCharacteristic)")
//        println("writing position2 ---> \(positionValue)")
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sendPosition(100)
        
        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var switchState: UISwitch!
    
    @IBAction func `switch`(sender: UISwitch) {
        
        if switchState.on {
            sendPosition(100)
            println("inside switch on")
        }
        else {
            sendPosition(105)
            println("inside switch off")
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
