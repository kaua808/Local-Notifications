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
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func timerTapped(_ sender: Any) {
        print("timer")
    }
    
    @IBAction func dateTapped(_ sender: Any) {
        print("date")
    }
    
    @IBAction func locationTapped(_ sender: Any) {
        print("location")
    }
    
}

