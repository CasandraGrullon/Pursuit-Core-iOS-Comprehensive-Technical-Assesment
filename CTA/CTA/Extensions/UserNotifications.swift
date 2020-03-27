//
//  UserNotifications.swift
//  CTA
//
//  Created by casandra grullon on 3/21/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit


class PendingNotifications {
    public func getPendingNotifications(completion: @escaping([UNNotificationRequest]) -> ()) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (request) in
            completion(request)
        }
    }
}
extension UIViewController {
    
    static func getNotification(title: String, body: String) {
        let notification = UNMutableNotificationContent()
        notification.title = title
        notification.body = body
        notification.sound = .default
        let identifier = UUID().uuidString
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Date().timeIntervalSinceNow + 2, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: notification, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("error when adding request: \(error)")
            } else {
                print("request was successfully added")
            }
        }
    }
}
