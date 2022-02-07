//
//  AppDelegate.swift
//  industrialchronometer
//
//  Created by ulas özalp on 31.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


   var window: UIWindow?
    var viewControllers : [UIViewController]?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
//        // Override point for customization after application launch.
//
//        //tabbar activities
//
//        //1 - create a window with the main screen dimensions
//        window = UIWindow(frame : UIScreen.main.bounds)
//
//        //2 - create storyboard. defaut story board
//
//
//
//        //3 integrate existing viewcontrollers into storyBoard
//
//       let tabBarController = TabBarViewController()
//        //tabBarController.viewControllers = viewControllers
//
//        // 5 make the tab bar controller the root view controller
//
//        window?.rootViewController = tabBarController
//        window?.makeKeyAndVisible()
//        
//
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
   

}

