import Foundation
import Testing
@testable import Domain

class ExchangeRatesTests {
    
    /// GIVEN: Exchange rates with currencies
    /// WHEN: Calculating currencies
    /// THEN: The result should be sorted
    @Test
    func testConversionResults_usingBase_areAccurate() {
        // Given
        let exchangeRates: ExchangeRates = .init(
            disclaimer: "Usage subject to terms: https://openexchangerates.org/terms",
            license: "https://openexchangerates.org/license",
            timestamp: 1733986800,
            base: "USD",
            rates: [
                "JPY": 152.4845,
                "EUR": 0.951103,
                "GBP": 0.783058
            ]
        )
        // When
        let results = exchangeRates.currencies
        let expectedResult = [
            "EUR",
            "GBP",
            "JPY"
        ]
        // Then
        #expect(results == expectedResult)
    }
        
}
