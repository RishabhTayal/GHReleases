//
//  AppDelegate.swift
//  GHReleases
//
//  Created by Tayal, Rishabh on 6/26/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { (s, e) in
            
        }
        
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let repo = Repository.instance(dict: ["owner": "fastlane", "name": "fastlane"])
        fetchData(repository: repo) { (d, e) in
            DispatchQueue.main.async {
                self.triggerLocalNotification()
            }
            completionHandler(UIBackgroundFetchResult.newData)
        }
    }
    
    func fetchData(repository: Repository, completion: @escaping ServiceCaller.CompletionBlock) {
        ServiceCaller().makeCall(repository: repository.owner + "/" + repository.name) { (items, error) in
            completion(items, error)
        }
    }
    
    func triggerLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Don't forget"
        content.body = "Buy Milk"
        content.sound = .default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (e) in
            
        }
    }
}

