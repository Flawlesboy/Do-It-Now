//
//  AppDelegate + Notification.swift
//  Are you doing anything?
//
//  Created by Загид Гусейнов on 27.04.2019.
//  Copyright © 2019 Загид Гусейнов. All rights reserved.
//

import Foundation
import UserNotifications
import AudioToolbox


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { ( granted, error) in
            print("Permision granted \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
        
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
    
    func scheduleNotification(createTask: CreateTask) {
        
        let content = UNMutableNotificationContent()
        
        content.title = "Задача"
        content.body = createTask.title!
        
        if let fileName = createTask.sound?.fileName {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: (fileName)))
        } else {
            content.sound = UNNotificationSound.default
        }
        
        
        content.badge = 1
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: createTask.notificationDate!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: "Local", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    
}
