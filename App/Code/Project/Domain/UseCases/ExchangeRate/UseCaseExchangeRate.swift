import Foundation
import Combine

public enum UseCaseExchangeRate {
    
    /// Fetches data from the API if the rate limit is not active
    /// Or from cache if it is
    /// Or fails if both methods are unavailable
    public static func fetchRates(
        datasource: UseCaseExchangeRateDatasource,
        persistence: UseCaseExchangeRatePersistence,
        currentDate: Date = Date(),
        limitInterval: TimeInterval = Constants.fetchLimitInSeconds
    ) -> AnyPublisher<ExchangeRates, Error> {
        
        let result = loadCache(persistence: persistence, currentDate: currentDate, limitInterval: limitInterval)
            .flatMap { cacheResult -> AnyPublisher<ExchangeRates, Error> in
                switch cacheResult {
                    case .useCache(let cachedRates):
                        return Just(cachedRates)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    case .fetchOnline:
                        return fetchAndStore(
                            datasource: datasource,
                            persistence: persistence
                        )
                }
            }
            .catch { _ in
                persistence
                    .load()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        return result
        
    }
    
}

private extension UseCaseExchangeRate {
    
    /// Loads cache and decides if the rate limit is active.
    static func loadCache(
        persistence: UseCaseExchangeRatePersistence,
        currentDate: Date,
        limitInterval: TimeInterval
    ) -> AnyPublisher<ExchangeRateSource, Error> {
        persistence
            .load()
            // Load cache and check rate limit
            .map { cachedData -> ExchangeRateSource in
                let lastFetchDate = Date(timeIntervalSince1970: cachedData.timestamp)
                let isRateLimited = UseCaseRateLimiter.isRateLimitActive(
                    lastUpdate: lastFetchDate,
                    currentDate: currentDate,
                    limitInterval: limitInterval
                )
                // Decide source depending on rate limit
                return isRateLimited ? .useCache(cachedData) : .fetchOnline
            }
            // If there's no cache, fetch online
            .catch { _ in
                Just(.fetchOnline)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    /// Fetches rates from the network and stores them locally.
    static func fetchAndStore(
        datasource: UseCaseExchangeRateDatasource,
        persistence: UseCaseExchangeRatePersistence
    ) -> AnyPublisher<ExchangeRates, Error> {
        datasource
            .fetchRates()
            .flatMap { exchangeRates in
                persistence
                    .save(exchangeRates: exchangeRates)
                    .map { exchangeRates }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - CacheResult Enum
private extension UseCaseExchangeRate {
    enum ExchangeRateSource {
        case useCache(ExchangeRates)
        case fetchOnline
    }
}
