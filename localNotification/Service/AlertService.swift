//
//  AlertService.swift
//  localNotification
//
//  Created by Kaleo Kim on 3/24/18.
//  Copyright © 2018 Kaleo Kim. All rights reserved.
//

import Foundation
import UIKit

class AlertService {
    
    private init() {}
    
    static func actionSheet(in vc: UIViewController, title: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default) { (_) in
            completion()
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
}
