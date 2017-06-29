//
//  AppDelegate.swift
//  GHReleases
//
//  Created by Tayal, Rishabh on 6/26/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import UIKit
import UserNotifications
import MWFeedParser

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
        if var repos = UserDefaults.standard.array(forKey: UserDefaultsKey.Repositories) {
            var apiCompletionCount = 0
            for repoObj in repos {
                let repo = Repository.instance(dict: repoObj as! [String : Any])
                fetchData(repository: repo) { (d, e) in
                    DispatchQueue.main.async {
                        apiCompletionCount += 1
                        if repo.version != d?.first?.title {
                            self.triggerLocalNotification(repository: repo, version: (d?.first?.title)!)
                            repo.version = d?.first?.title
                            UserDefaults.storeRepo(repository: repo)
                        }
                        
                        if apiCompletionCount == repos.count {
                            completionHandler(UIBackgroundFetchResult.newData)
                        }
                    }
                }
            }
        } else {
            completionHandler(.noData)
        }
    }
    
    func fetchData(repository: Repository, completion: @escaping ServiceCaller.CompletionBlock) {
        ServiceCaller().makeCall(repository: repository.owner + "/" + repository.name) { (items, error) in
            completion(items, error)
        }
    }
    
    func triggerLocalNotification(repository: Repository, version: String) {
        let content = UNMutableNotificationContent()
        content.title = "New release available"
        content.subtitle = version
        content.body = repository.owner + " released a new release for " + repository.name
        content.sound = .default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (e) in
            
        }
    }
}

