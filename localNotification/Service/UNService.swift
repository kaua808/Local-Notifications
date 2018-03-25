//
//  UNService.swift
//  localNotification
//
//  Created by Kaleo Kim on 3/23/18.
//  Copyright © 2018 Kaleo Kim. All rights reserved.
//

import Foundation
import UserNotifications

// This has to be a subclass of NSObject in order to be able to access the delegates
// needed to know if the notification happened and the app is in the foreground or was
// responded to or something
class UNService: NSObject {
    
    // This makes it so that you can never creat a UNService Object anywhereelse
    // but only acces the shared instance or acces variabes and so on.
    // and because its part of NSObject you need override, otherwise you wouldnt.
    private override init() {}
    static let shared = UNService()
    
    let unCenter = UNUserNotificationCenter.current()
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "no UN auth error")
            guard granted else {
                print("user denied access")
                return
            }
            self.configure()
        }
    }
    
    func configure() {
        unCenter.delegate = self
    }
    
    func setupActionsAndCategories() {
        let timerAction = UNNo
    }
    
    func getAttachment(for id: NotificationAttachmentID) -> UNNotificationAttachment? {
        
        var imageName = ""
        
        switch id {
        case .timer: imageName = "TimeAlert"
        case .date: imageName = "DateAlert"
        case .location: imageName = "LocationAlert"
        }
        
        guard let url = Bundle.main.url(forResource: imageName, withExtension: "png") else {
            return nil
        }
        
        do {
            let attachment = try UNNotificationAttachment(identifier: id.rawValue, url: url, options: nil)
            return attachment
        } catch {
                return nil
        }
    }
    
    func timerRequest(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your timer is all done"
        content.sound = .default()
        // This is the badge count and we are setting it to one to keep it simple
        // you can set up logic to increment that depending on how much notifications there are
        content.badge = 1
        
        if let attachment = getAttachment(for: .timer) {
            content.attachments = [attachment]
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.timer", content: content, trigger: trigger)
        
        unCenter.add(request, withCompletionHandler: nil)
    }
    
    func dateRequest(with components: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = "Date Trigger"
        content.body = "It is now the future present"
        content.sound = .default()
        content.badge = 1
        
        if let attachment = getAttachment(for: .date) {
            content.attachments = [attachment]
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.date", content: content, trigger: trigger)
        
        unCenter.add(request, withCompletionHandler: nil)
    }
    
    func locationRequest() {
        let content = UNMutableNotificationContent()
        content.title = "You have returned"
        content.body = "welcome back"
        content.sound = .default()
        content.badge = 1
        
        if let attachment = getAttachment(for: .location) {
            content.attachments = [attachment]
        }
        
        let request = UNNotificationRequest(identifier: "userNotification.location", content: content, trigger: nil)
        
        unCenter.add(request, withCompletionHandler: nil)
    }
}

extension UNService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did recieve response")
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}



