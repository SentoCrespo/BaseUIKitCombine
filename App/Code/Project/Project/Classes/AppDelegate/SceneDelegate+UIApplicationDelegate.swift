// swiftlint:disable line_length
import Foundation
import UIKit

// MARK: - UIApplicationDelegate
extension SceneDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // Call the composite delegate
        let result = sceneDelegate.application?(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        return result ?? false
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Call the composite delegate
        sceneDelegate.applicationWillResignActive?(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Call the composite delegate
        sceneDelegate.applicationDidEnterBackground?(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Call the composite delegate
        sceneDelegate.applicationWillEnterForeground?(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Call the composite delegate
        sceneDelegate.applicationDidBecomeActive?(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Call the composite delegate
        sceneDelegate.applicationWillTerminate?(application)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let result = sceneDelegate.application?(
            app,
            open: url,
            options: options
        )
        return result ?? false
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Call the composite delegate
        sceneDelegate.application?(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
        )
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        // Call the composite delegate
        sceneDelegate.application?(
            application,
            didFailToRegisterForRemoteNotificationsWithError: error
        )
        
    }
    
    // swiftlint:disable:next line_length
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // Call the composite delegate
        sceneDelegate.application?(
            application,
            didReceiveRemoteNotification: userInfo,
            fetchCompletionHandler: completionHandler
        )
        
    }
    
}
