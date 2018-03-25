//
//  ViewController.swift
//  localNotification
//
//  Created by Kaleo Kim on 3/23/18.
//  Copyright © 2018 Kaleo Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNService.shared.authorize()
        CLService.shared.authorize()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterRegion), name: Notification.Name(rawValue: "internalNotification.enterRegion"), object: nil)
    }

    @IBAction func timerTapped(_ sender: Any) {
        print("timer")
        AlertService.actionSheet(in: self, title: "5 seconds") {
            UNService.shared.timerRequest(with: 5)
        }
    }
    
    @IBAction func dateTapped(_ sender: Any) {
        print("date")
        
        AlertService.actionSheet(in: self, title: "some future time") {
            var components = DateComponents()
            // this date component second is saying when ever the calendar on the device second goes to 0 it will trigger
            // if I did components.weekday = 1 it will trigger every sunday
            // ad because the repeat was wet to true in the UNService it will send this every minute or ever time the seconds go to 0
            components.second = 0
            
            UNService.shared.dateRequest(with: components)
        }
        
    }
    
    @IBAction func locationTapped(_ sender: Any) {
        print("location")
        
        AlertService.actionSheet(in: self, title: "when I return") {
            CLService.shared.updateLocation()
        }
    }
    
    @objc func didEnterRegion() {
        UNService.shared.locationRequest()
    }
    
}

