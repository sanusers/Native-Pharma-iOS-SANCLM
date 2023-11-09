//
//  AppDelegate.swift
//  E-Detailing
//
//  Created by PARTH on 21/04/23.
//

import UIKit
import CoreData
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        GMSServices.provideAPIKey("AIzaSyCWeKbT2OcoH82bQJQJKqrHZ_MyLGijWM4")
        
        self.setupRootViewControllers()
        return true
    }
    
    
    func setupRootViewControllers() {
        
        
        let tourplanVC = TourPlanVC.initWithStory()
        self.window?.rootViewController = UINavigationController.init(rootViewController: tourplanVC)
        
//        if !AppDefaults.shared.isConfigAdded() {
//            self.window?.rootViewController = UIStoryboard.apiconfigNavigationVC
//        } else {
//
//            _ = AppDefaults.shared.getConfig()
//
//            if AppDefaults.shared.isLoggedIn() && DBManager.shared.hasMasterData() {
//                self.window?.rootViewController = UINavigationController.init(rootViewController: UIStoryboard.mainVC)
//
//            }else if AppDefaults.shared.isLoggedIn() {
//                let mastersyncVC = UIStoryboard.masterSyncVC
//                mastersyncVC.isFromLaunch = true
//                self.window?.rootViewController = UINavigationController.init(rootViewController:mastersyncVC)
//
//            }else {
//                self.window?.rootViewController = UINavigationController.init(rootViewController: UIStoryboard.loginVC)
//            }
//        }
    }
}

