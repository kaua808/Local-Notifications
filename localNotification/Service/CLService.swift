//
//  CLService.swift
//  localNotification
//
//  Created by Kaleo Kim on 3/24/18.
//  Copyright © 2018 Kaleo Kim. All rights reserved.
//

import Foundation
import CoreLocation

class CLService: NSObject {
    
    private override init() {}
    static let shared = CLService()
    
    let locationManager = CLLocationManager()
    var shouldSetRegion = true
    
    func authorize() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func updateLocation() {
        shouldSetRegion = true
        locationManager.startUpdatingLocation()
    }
}

extension CLService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got location")
        guard let currentLocation = locations.first, shouldSetRegion else { return }
        shouldSetRegion = false
        let region = CLCircularRegion(center: currentLocation.coordinate, radius: 20, identifier: "startPosition")
        manager.startMonitoring(for: region)
    }
    
    // The reason we want to observe this region and see when we enter is cause in the
    // UNService we wont have a trigger in the location request cause that method isnt very reliable
    // so this essential replaces that trigger
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("did enter region via CL")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "internalNotification.enterRegion"), object: nil)
    }
}
