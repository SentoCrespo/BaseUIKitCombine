// swiftlint:disable line_length
import Foundation
import UIKit

// MARK: - UISceneDelegate
extension SceneDelegate: UISceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        sceneDelegate.scene?(
            scene,
            willConnectTo: session,
            options: connectionOptions
        )
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        sceneDelegate.sceneDidDisconnect?(scene)
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        sceneDelegate.sceneDidBecomeActive?(scene)
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        sceneDelegate.sceneWillResignActive?(scene)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        sceneDelegate.sceneWillEnterForeground?(scene)
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        sceneDelegate.sceneDidEnterBackground?(scene)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        sceneDelegate.scene?(scene, openURLContexts: URLContexts)
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        sceneDelegate.stateRestorationActivity?(for: scene)
    }

    func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        sceneDelegate.scene?(scene, willContinueUserActivityWithType: userActivityType)
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        sceneDelegate.scene?(scene, continue: userActivity)
    }

    func scene(_ scene: UIScene, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        sceneDelegate.scene?(scene, didFailToContinueUserActivityWithType: userActivityType, error: error)
    }
    
    func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) {
        sceneDelegate.scene?(scene, didUpdate: userActivity)
    }
    
}
