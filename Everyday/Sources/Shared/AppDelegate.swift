//
//  AppDelegate.swift
//  Everyday
//
//  Created by Cocoa on 2018. 7. 27..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import UIKit
import RealmSwift

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
            
            let realm = try! Realm()
            let repo = RealmEntryRepository(realm: realm)
            
            let env = Environment(
                entryRepository: repo,
                entryFactory: RealmEntry.entry,
                settings: UserDefaults.standard
            )
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            
            timelineViewController.viewModel = TimelineViewViewModel(environment: env)
        }
    }
}

