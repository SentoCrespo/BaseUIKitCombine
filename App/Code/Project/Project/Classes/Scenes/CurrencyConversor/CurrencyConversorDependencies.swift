import Foundation
import Domain
import Data

/// Container with explicit dependencies for the scene
struct CurrencyConversorDependencies {
    
    // MARK: - Properties
    let mainStore: AppReduxStore
    let datasource: UseCaseExchangeRateDatasource
    let persistence: UseCaseExchangeRatePersistence
    
}

extension CurrencyConversorDependencies {
    
    static var `default`: CurrencyConversorDependencies {
        let result = CurrencyConversorDependencies(
            mainStore: Application.shared.store,
            datasource: UseCaseExchangeRateAPI(),
            persistence: UseCaseExchangeRatePersistenceDisk()
        )
        return result
    }
    
    static var local: CurrencyConversorDependencies {
        let result = CurrencyConversorDependencies(
            mainStore: Application.shared.store,
            datasource:
                UseCaseExchangeRateDatasourceLocal(
                bundle: Bundle(for: UseCaseExchangeRateDatasourceLocal.self),
                filename: "latest"
            ),
            persistence: UseCaseExchangeRatePersistenceMemory()
        )
        return result
    }
    
}
