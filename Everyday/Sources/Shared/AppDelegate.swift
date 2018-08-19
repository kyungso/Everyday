//
//  AppDelegate.swift
//  Everyday
//
//  Created by Cocoa on 2018. 7. 27..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var environment: Environment!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        customizeNavigationBar()
        
        injectEnvironment()
        
        return true
    }

    private func customizeNavigationBar() {
        if let navViewController = window?.rootViewController as? UINavigationController {
            navViewController.navigationBar.prefersLargeTitles = true
            navViewController.navigationBar.barStyle = .black
            navViewController.navigationBar.tintColor = UIColor.white
            
            let bgimage = UIImage.gradientImage(with: [.gradientStart, .gradientEnd], size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
            navViewController.navigationBar.barTintColor = UIColor(patternImage: bgimage!)
        }
    }
    
    private func injectEnvironment(){
        
        if
            let navigationController = window?.rootViewController as? UINavigationController,
            let timelineViewController = navigationController.topViewController as? TimelineViewController {
            let entries: [Entry] = [ // 어제
                Entry(createdAt: Date.before(1), text: "어제 일기"), Entry(createdAt: Date.before(1), text: "어제 일기"), Entry(createdAt: Date.before(1), text: "어제 일기"),
                // 2일 전
                Entry(createdAt: Date.before(2), text: "2일 전 일기"), Entry(createdAt: Date.before(2), text: "2일 전 일기"), Entry(createdAt: Date.before(2), text: "2일 전 일기"), Entry(createdAt: Date.before(2), text: "2일 전 일기"), Entry(createdAt: Date.before(2), text: "2일 전 일기"), Entry(createdAt: Date.before(2), text: "2일 전 일기"),
                // 3일 전
                Entry(createdAt: Date.before(3), text: "3일 전 일기"), Entry(createdAt: Date.before(3), text: "3일 전 일기")
            ]
    
            let repo = InMemoryEntryRepository(entries: entries)
            timelineViewController.environment = Environment(entryRepository: repo)
        }
    }
        
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

