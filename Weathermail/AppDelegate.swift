//
//  AppDelegate.swift
//  Weathermail
//
//  Created by Atsuhiro Muroyama on 2022/05/22.
//

import UIKit
import os

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


//    func application(_ application: Bool {
//
//        let navigationController = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "initView"))
//        self.window?.rootViewVontroller = navigationController
//
//        return true
//    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .sound, .badge]){
            (granted, _) in
            if granted{
                UNUserNotificationCenter.current().delegate = self
            }
        }
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
    func applicationSignificantTimeChange(_ application: UIApplication) {
//           NotificationCenter.default.post(name: .dayChanged, object: nil)
        
       }


}
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
 
        os_log("Notified")
        // アプリ起動時も通知を行う
        completionHandler([.sound, .alert ])
    }
}
//extension Notification.Name {
//    static let dayChanged = Notification.Name("dayChanged")
//}
