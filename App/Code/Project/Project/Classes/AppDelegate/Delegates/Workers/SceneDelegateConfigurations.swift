// swiftlint:disable line_length
import Foundation
import UIKit
import Domain

/// Perform data configurations, e.g. datasource, persistence, ...
class SceneDelegateConfigurations: SceneDelegateType {
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
}

// MARK: - App Delegate
extension SceneDelegateConfigurations {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        self.initApiEnvironment()
        self.initDatasourceConfiguration()
        
        return true
    }
    
}

// MARK: - Scene Delegate
extension SceneDelegateConfigurations {
    
}

// MARK: - Private Methods
private extension SceneDelegateConfigurations {
    
    func initApiEnvironment() {
//        if WUManagerEnvironment.isDebugFlag {
//            self.apiEnvironment = .integration
//        } else if WUManagerEnvironment.isAdhocFlag {
//            self.apiEnvironment = .demo
//        } else if WUManagerEnvironment.isReleaseFlag {
//            self.apiEnvironment = .production
//        } else {
//            self.apiEnvironment = .production
//        }
//        self.apiEnvironment = .production
    }
    
    func initDatasourceConfiguration() {
//        self.dataSourceConfiguration = DataSourceConfiguration()
    }
    
}
