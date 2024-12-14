import Foundation
import Combine

public protocol UseCaseExchangeRatePersistence {
    func save(exchangeRates: ExchangeRates) -> AnyPublisher<Void, Error>
    func load() -> AnyPublisher<ExchangeRates, Error>
}
