import Foundation
import UIKit
import SharedUtils

@main
class SceneDelegate: UIResponder {
    
    // MARK: - Properties
    var window: UIWindow?
    // swiftlint:disable:next weak_delegate
    var sceneDelegate = BuildType.isTest ?
        SceneDelegateFactory.makeTest() :
        SceneDelegateFactory.makeDefault()
    
}

// MARK: Global Variables

// MARK: Computed Variables
extension SceneDelegate {
    
    static var shared: SceneDelegate {
        guard let result = UIApplication.shared.delegate as? SceneDelegate else {
            // For tests if App is not ready yet
            let sceneDelegate = SceneDelegate()
            _ = sceneDelegate.application(
                UIApplication.shared,
                didFinishLaunchingWithOptions: [:]
            )
            return sceneDelegate
        }
        return result
    }
    
    var compositeDelegate: CompositeSceneDelegate? {
        return SceneDelegate.shared.sceneDelegate as? CompositeSceneDelegate
    }

}
