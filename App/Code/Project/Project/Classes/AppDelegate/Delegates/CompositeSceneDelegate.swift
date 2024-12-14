// swiftlint:disable line_length
import Foundation
import UIKit

class CompositeSceneDelegate: SceneDelegateType {
    
    // MARK: - Properties
    private let sceneDelegates: [SceneDelegateType]
    
    // MARK: - Life Cycle
    init(sceneDelegates: [SceneDelegateType]) {
        self.sceneDelegates = sceneDelegates
    }
    
}

// MARK: - App Delegate
extension CompositeSceneDelegate {
    
    @discardableResult
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let result = sceneDelegates
            .allSatisfy {
                return $0.application?(
                    application,
                    didFinishLaunchingWithOptions: launchOptions) ?? false
        }
        return result
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        sceneDelegates.forEach {
            $0.applicationWillResignActive?(application)
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        sceneDelegates.forEach {
            $0.applicationDidEnterBackground?(application)
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        sceneDelegates.forEach {
            $0.applicationWillEnterForeground?(application)
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        sceneDelegates.forEach {
            $0.applicationDidBecomeActive?(application)
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        sceneDelegates.forEach {
            $0.applicationWillTerminate?(application)
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let result = sceneDelegates
            .allSatisfy {
                return $0.application?(app, open: url, options: options) ?? false
        }
        return result
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        sceneDelegates.forEach {
            $0.application?(
                application,
                didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        sceneDelegates.forEach {
            $0.application?(
                application,
                didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        sceneDelegates.forEach {
            $0.application?(
                application,
                didReceiveRemoteNotification: userInfo,
                fetchCompletionHandler: completionHandler)
        }
    }
    
}

// MARK: - Scene Delegate
extension CompositeSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        sceneDelegates.forEach {
            $0.scene?(
                scene,
                willConnectTo: session,
                options: connectionOptions)
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        sceneDelegates.forEach {
            $0.sceneDidDisconnect?(scene)
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        sceneDelegates.forEach {
            $0.sceneDidBecomeActive?(scene)
        }
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        sceneDelegates.forEach {
            $0.sceneWillResignActive?(scene)
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        sceneDelegates.forEach {
            $0.sceneWillEnterForeground?(scene)
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        sceneDelegates.forEach {
            $0.sceneDidEnterBackground?(scene)
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        sceneDelegates.forEach {
            $0.scene?(scene, openURLContexts: URLContexts)
        }
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        let allResults = sceneDelegates.compactMap { delegate in
            return delegate.stateRestorationActivity?(for: scene)
        }
        // This returns the last activity found
        let result = allResults.last
        return result
    }

    func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        sceneDelegates.forEach {
            $0.scene?(scene, willContinueUserActivityWithType: userActivityType)
        }
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        sceneDelegates.forEach {
            $0.scene?(scene, continue: userActivity)
        }
    }

    func scene(_ scene: UIScene, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        sceneDelegates.forEach {
            $0.scene?(scene,
                      didFailToContinueUserActivityWithType: userActivityType,
                      error: error)
        }
    }
    
    func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) {
        sceneDelegates.forEach {
            $0.scene?(scene, didUpdate: userActivity)
        }
    }
    
}

// MARK: - Public Methods
extension CompositeSceneDelegate {
    
    func delegate<T: SceneDelegateType>(type: T.Type) -> T? {
        let result = sceneDelegates
            .first(where: {
                return $0 is T
            }).flatMap {
                return $0 as? T
        }
        return result
    }
    
}
