import Foundation
import Combine
import SharedUtils

// sourcery:AutoInit
public final class UseCaseExchangeRateAPI: UseCaseExchangeRateDatasource {
    
    // sourcery:inline:auto:UseCaseExchangeRateAPI.AutoInit
        // MARK: - Life Cycle
        public init() {
    	}
    // sourcery:end
    
    public func fetchRates() -> AnyPublisher<ExchangeRates, Error> {
        let request = OpenExchange.build(path: "latest.json")
        print(request.cURL())
        return URLSession
            .shared
            .perform(
                request: request,
                decoding: ExchangeRates.self
            )
    }
    
}
