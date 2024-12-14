import Foundation
import Combine

public protocol UseCaseExchangeRateDatasource {
    func fetchRates() -> AnyPublisher<ExchangeRates, Error>
}
