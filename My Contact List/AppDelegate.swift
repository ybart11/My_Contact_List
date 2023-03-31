//
//  AppDelegate.swift
//  My Contact List
//
//  Created by Yovany Bartolome on 3/28/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let settings = UserDefaults.standard
        
        // Checks if 'sortField' has been set. If not, it stores 'City' as the value in sortField
        if settings.string(forKey: "sortField") == nil {
            settings.set("City", forKey: "sortField")
        }
        
        // Checks if 'sortDirectionAscending' has been set. If not, it defaults to true
        if settings.string(forKey: "sortDirectionAscending") == nil {
            settings.set(true, forKey: "sortDirectionAscending")
        }
        
        // Ensures that any changes are saved back to the settings file
        settings.synchronize()
        
        // Write the values of the two settings fields to NSLog
        print("Sort field: \(settings.string(forKey: "sortField")!)") // Retrieve string 
        print("Sort direction: \(settings.bool(forKey: "sortDirectionAscending"))") // Retrieve Boolean value
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

