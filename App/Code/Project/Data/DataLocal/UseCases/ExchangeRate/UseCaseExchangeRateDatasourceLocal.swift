import Foundation
import Combine

public final class UseCaseExchangeRateDatasourceLocal: UseCaseExchangeRateDatasource {
    
    // MARK: - Properties
    private let localLoader: UseCaseLocal<ExchangeRates>
    
    // MARK: - Life Cycle
    public init(bundle: Bundle, filename: String) {
        self.localLoader = UseCaseLocal<ExchangeRates>(
            bundle: bundle,
            filename: filename
        )
    }
    
    // MARK: - UseCaseExchangeRateDatasource
    public func fetchRates() -> AnyPublisher<ExchangeRates, Error> {
        return localLoader.fetch()
    }
    
}
