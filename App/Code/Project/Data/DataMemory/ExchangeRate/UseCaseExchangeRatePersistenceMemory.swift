import Foundation
import Combine

// sourcery:AutoInit
public final class UseCaseExchangeRatePersistenceMemory: UseCaseExchangeRatePersistence {
    
    // MARK: - Properties
    var exchangeRates: ExchangeRates?

    // sourcery:inline:auto:UseCaseExchangeRatePersistenceMemory.AutoInit
        // MARK: - Life Cycle
        public init(
            exchangeRates: ExchangeRates? = nil
            ) {
    		self.exchangeRates = exchangeRates
    	}
    // sourcery:end
}

// MARK: - UseCaseExchangeRatePersistence
public extension UseCaseExchangeRatePersistenceMemory {
    
    func save(exchangeRates: ExchangeRates) -> AnyPublisher<Void, Error> {
        self.exchangeRates = exchangeRates
        return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
    }

    func load() -> AnyPublisher<ExchangeRates, Error> {
        guard let persistedData = self.exchangeRates else {
            let error = NSError(domain: "No data found", code: 404)
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        return Just(persistedData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}
