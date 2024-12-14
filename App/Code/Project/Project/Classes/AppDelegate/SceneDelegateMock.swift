// swiftlint:disable line_length
import Foundation
import UIKit

class SceneDelegateMock: SceneDelegateType {
    
    // MARK: - Properties
    var methodCalled: [String: Bool] = [:]
    
    // MARK: - Life Cycle
    
}

// MARK: - AppDelegate
extension SceneDelegateMock {
    
    @discardableResult
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        methodCalled["didFinishLaunchingWithOptions"] = true
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        methodCalled["applicationWillResignActive"] = true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        methodCalled["applicationDidEnterBackground"] = true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        methodCalled["applicationWillEnterForeground"] = true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        methodCalled["applicationDidBecomeActive"] = true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        methodCalled["applicationWillTerminate"] = true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        methodCalled["openUrlOptions"] = true
        return false
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        methodCalled["didRegisterForRemoteNotificationsWithDeviceToken"] = true
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        methodCalled["didFailToRegisterForRemoteNotificationsWithError"] = true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        methodCalled["didReceiveRemoteNotification"] = true
    }
    
}

// MARK: - Scene Delegate
extension SceneDelegateMock {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        methodCalled["sceneWillConnectToSessionWithConnectionOptions"] = true
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        methodCalled["sceneDidDisconnect"] = true
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        methodCalled["sceneDidBecomeActive"] = true
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        methodCalled["sceneWillResignActive"] = true
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        methodCalled["sceneWillEnterForeground"] = true
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        methodCalled["sceneDidEnterBackground"] = true
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        methodCalled["openURLContexts"] = true
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        methodCalled["stateRestorationActivity"] = true
        return nil
    }

    func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        methodCalled["willContinueUserActivityWithType"] = true
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        methodCalled["continueUserActivity"] = true
    }

    func scene(_ scene: UIScene, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        methodCalled["didFailToContinueUserActivityWithType"] = true
    }
    
    func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) {
        methodCalled["didUpdateUserActivity"] = true
    }
    
}
