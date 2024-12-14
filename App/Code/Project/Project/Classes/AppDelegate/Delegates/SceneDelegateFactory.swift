import Foundation

enum SceneDelegateFactory {

    // MARK: - Properties
    
    // MARK: - Life Cycle
    
}

// MARK: - Public Methods
extension SceneDelegateFactory {
    
    static func makeDefault() -> SceneDelegateType {
        return CompositeSceneDelegate(
            sceneDelegates: [
                SceneDelegateThirdParty(),
                SceneDelegateDebug(),
                SceneDelegateConfigurations(),
                SceneDelegateStartup()
            ]
        )
    }
    
    static func makeTest() -> SceneDelegateType {
        return CompositeSceneDelegate(
            sceneDelegates: [
                SceneDelegateMock(),
                SceneDelegateConfigurations()
            ]
        )
    }
    
}
