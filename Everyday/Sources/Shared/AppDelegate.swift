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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        customizeNavigationBar()
        
        injectEnvironment()
        
        return true
    }

    private func customizeNavigationBar() {
        if let navViewController = window?.rootViewController as? UINavigationController {
            navViewController.navigationBar.prefersLargeTitles = true
            navViewController.navigationBar.barStyle = .black
            navViewController.navigationBar.tintColor = .white
            
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
            let env = Environment(
                entryRepository: repo,
                settings: UserDefaults.standard
            ) 
            timelineViewController.viewModel = TimelineViewViewModel(environment: env)
        }
    }
}

