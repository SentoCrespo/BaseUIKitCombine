import Foundation
import Testing
import Combine
import SharedUtils
import Data
@testable import Domain

class UseCaseExchangeRateTests {
    
    // MARK: - Properties
    private let currentDate = UseCaseExchangeRateTests.testDate
    private let limitInterval = Constants.fetchLimitInSeconds
    private var cancellables: Set<AnyCancellable> = []
    
    /// GIVEN: Cached data exists and the rate limit is active
    /// WHEN: Fetching exchange rates
    /// THEN: It should return the cached data
    @Test
    func testFetchRates_usesCacheWhenRateLimitActive() {
        // Given
        let lastFetchedDate = currentDate.timeIntervalSince1970 - limitInterval + 1
        let cachedRates = self.exchangeRates(timestamp: lastFetchedDate)
        let datasourceMock = UseCaseExchangeRateDatasourceMock()
        let persistenceMock = UseCaseExchangeRatePersistenceMemory()
        
        // When
        var result: ExchangeRates?
        // Create Cache data
        persistenceMock
            .save(exchangeRates: cachedRates)
            .flatMap { [unowned self] in
                // Trigger opertaion
                UseCaseExchangeRate
                    .fetchRates(
                        datasource: datasourceMock,
                        persistence: persistenceMock,
                        currentDate: self.currentDate,
                        limitInterval: self.limitInterval
                    )
            }
            .sink(
                receiveValue: { value in
                    result = value
                }
            )
            .store(in: &cancellables)
        
        //  Then
        #expect(result == cachedRates)
    
    }
    
    /// GIVEN: Cached data exists and the rate limit is not active
    /// WHEN: Fetching exchange rates
    /// THEN: It should fetch data online and save it
    @Test
    func testFetchRates_fetchesOnlineWhenRateLimitNotActive() {
        // Given
        let lastFetchedDate = currentDate.timeIntervalSince1970 - limitInterval - 1
        let cachedRates = self.exchangeRates(timestamp: lastFetchedDate)
        let newFetchDate = currentDate.timeIntervalSince1970
        let newRates = self.exchangeRates(timestamp: newFetchDate)
        let datasourceMock = UseCaseExchangeRateDatasourceMock()
            .withExchangeRates(.success(newRates))
        let persistenceMock = UseCaseExchangeRatePersistenceMemory()
        
        // When
        var result: ExchangeRates?
        var localResult: ExchangeRates?
        
        // Create Cache data
        persistenceMock
            .save(exchangeRates: cachedRates)
        // Trigger opertaion
            .flatMap { [unowned self] in
                UseCaseExchangeRate
                    .fetchRates(
                        datasource: datasourceMock,
                        persistence: persistenceMock,
                        currentDate: self.currentDate,
                        limitInterval: self.limitInterval
                    )
            }
        // Load Cache data
            .flatMap { exchangeRates in
                persistenceMock
                    .load()
                    .map {
                        return (exchangeRates, $0)
                    }
            }
        // Check it's stored
            .sink(
                receiveValue: { (onlineData, cacheData) in
                    result = onlineData
                    localResult = cacheData
                }
            )
            .store(in: &cancellables)
        
        // Then
        #expect(result == newRates)
        #expect(localResult == newRates)
    }
    
    /// GIVEN: No cached data exists
    /// WHEN: Fetching exchange rates
    /// THEN: It should fetch data online and save it
    @Test
    func testFetchRates_fetchesOnlineWhenNoCacheExists() {
        // Given
        let newFetchDate = currentDate.timeIntervalSince1970
        let newRates = self.exchangeRates(timestamp: newFetchDate)
        let datasourceMock = UseCaseExchangeRateDatasourceMock()
            .withExchangeRates(.success(newRates))
        let persistenceMock = UseCaseExchangeRatePersistenceMemory()
        
        // When
        var result: ExchangeRates?
        var localResult: ExchangeRates?
        
        UseCaseExchangeRate
            .fetchRates(
                datasource: datasourceMock,
                persistence: persistenceMock,
                currentDate: self.currentDate,
                limitInterval: self.limitInterval
            )
            // Load Cache data
            .flatMap { exchangeRates in
                persistenceMock
                    .load()
                    .map {
                        return (exchangeRates, $0)
                    }
            }
            // Check it's stored
            .sink(
                receiveValue: { (onlineData, cacheData) in
                    result = onlineData
                    localResult = cacheData
                }
            )
            .store(in: &cancellables)
        
        // Then
        #expect(result == newRates)
        #expect(localResult == newRates)
    }
    
    /// GIVEN: No cached data exists
    /// AND: No internet connection
    /// WHEN: Fetching exchange rates
    /// THEN: It should fail with a `noInternetAndNoCache` error
    @Test
    func testFetchRates_failsWhenNoCacheAndNoInternet() {
        // Given
        let errorDatasource = NSError(domain: "No data found", code: 404)
        let datasourceMock = UseCaseExchangeRateDatasourceMock()
            .withExchangeRates(.failure(errorDatasource))
        let persistenceMock = UseCaseExchangeRatePersistenceMemory()
        
        // When
        let result: ExchangeRates? = nil
        var resultError: NSError?
        
        UseCaseExchangeRate
            .fetchRates(
                datasource: datasourceMock,
                persistence: persistenceMock,
                currentDate: self.currentDate,
                limitInterval: self.limitInterval
            )
            // Check it's stored
            .sink(
                receiveError: { error in
                    resultError = error as NSError
                })
            .store(in: &cancellables)
        
        // Then
        #expect(result == nil)
        #expect(resultError == errorDatasource)
        
    }
    
}

private extension UseCaseExchangeRateTests {
    
    func exchangeRates(timestamp: TimeInterval) -> ExchangeRates {
        let result = ExchangeRates(
            disclaimer: "Usage subject to terms: https://openexchangerates.org/terms",
            license: "https://openexchangerates.org/license",
            timestamp: timestamp,
            base: "USD",
            rates: [
                "EUR": 0.9
            ]
        )
        return result
    }
    
    static var testDate: Date {
        let calendar = Calendar.current
        let result = calendar.date(
            from: DateComponents(
                year: 1987,
                month: 2,
                day: 9
            )
        )
        return result!
    }
    
}
