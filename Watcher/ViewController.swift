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
    @IBOutlet weak var iphoneChargeCircle: MKRingProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isBatteryMonitoringEnabled = true
        chargeLabel.text = String("\(Int(UIDevice.current.batteryLevel*100))%")
        iphoneChargeCircle.progress = Double(UIDevice.current.batteryLevel)
        
        self.view.backgroundColor = lightStyleColor
        
        configureProgressBar()
        configureNavigationBar()
        
           }
    
    
    func configureNavigationBar() -> Void {
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: lightStyleColor]
        self.navigationController?.navigationBar.backgroundColor = darkStyleColor
        self.navigationItem.title = "Watcher"
        self.navigationController?.navigationBar.barTintColor = darkStyleColor
        self.navigationController?.navigationBar.isTranslucent = true;
        
        let shadowView = UIView(frame: self.navigationController!.navigationBar.frame)
        shadowView.backgroundColor = UIColor.black
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOpacity = 0.4
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2) 
        shadowView.layer.shadowRadius =  4
        self.view.addSubview(shadowView)

       
    }
    
    func configureProgressBar() {
        
        iphoneChargeCircle.backgroundColor = lightStyleColor
        iphoneChargeCircle.shadowOpacity = 0.5
        iphoneChargeCircle.backgroundRingColor = darkStyleColor

        
        switch UIDevice.current.batteryState {
        case .unknown:
            
            break
        case .unplugged:
            iphoneChargeCircle.startColor = lightBlueColor
            iphoneChargeCircle.endColor = darkBlueColor
            break
        case .charging:
            iphoneChargeCircle.startColor = lightGreenColor
            iphoneChargeCircle.endColor = darkGreenColor
            break
        case .full:
            iphoneChargeCircle.startColor = lightGreenColor
            iphoneChargeCircle.endColor = darkGreenColor
            break
        default:
            break
        }
        
        if (UIDevice.current.batteryLevel < 0.11) {
            iphoneChargeCircle.startColor = lightRedColor
            iphoneChargeCircle.endColor = darkRedColor
            
        }
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
        configureProgressBar()
    }
    
    func batteryLevelDidChange(_ notification: NSNotification) -> Void {
        chargeLabel.text = String("\(Int(UIDevice.current.batteryLevel*100))%")
        iphoneChargeCircle.progress = Double(UIDevice.current.batteryLevel)
        configureProgressBar()

        
    }

}

