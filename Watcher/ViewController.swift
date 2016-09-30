//
//  ViewController.swift
//  Watcher
//
//  Created by indieg0 on 9/30/16.
//  Copyright © 2016 indieg0. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chargeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isBatteryMonitoringEnabled = true
        chargeLabel.text = String(UIDevice.current.batteryLevel*100)
        
        print ("Lol")
        
        
        
           }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.batteryStateDidChange(_:)), name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.batteryLevelDidChange(_:)), name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func batteryStateDidChange(_ notification: NSNotification) -> Void {
      
        let batteryStatus = ["Battery status is unknown.",
                              "Battery is in use (discharging).",
                               "Battery is charging.",
                                "Battery is fully charged."]
        
        var msg : String
        
        
        switch UIDevice.current.batteryState {
        case .unknown:
            msg = batteryStatus[0]
            break
        case .unplugged:
            msg = batteryStatus[1]
            break
        case .charging:
            msg = batteryStatus[2]
            break
        case .full:
            msg = batteryStatus[3]
            break
        default:
            break
        }
        

        let alert = UIAlertController.init(title: "State did change!", message: msg, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func batteryLevelDidChange(_ notification: NSNotification) -> Void {
        chargeLabel.text = String(UIDevice.current.batteryLevel*100)
        
    }

}

