//
//  ShadowView.swift
//  localNotification
//
//  Created by Kaleo Kim on 3/23/18.
//  Copyright © 2018 Kaleo Kim. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        layer.shadowPath = CGPath(rect: layer.bounds, transform: nil)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        layer.cornerRadius = 5
    }

}
