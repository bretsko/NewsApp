//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navController = UINavigationController() //create navController
        coordinator = MainCoordinator(navigationController: navController) //initialize our coordinator
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController //make it our root
        window?.makeKeyAndVisible()
//        window?.windowScene = windowScene
        coordinator?.start() //start coordinator
        
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let initialViewController : UIViewController =
//            mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as
//            UIViewController
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = navController
//        self.window?.makeKeyAndVisible()
        
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

