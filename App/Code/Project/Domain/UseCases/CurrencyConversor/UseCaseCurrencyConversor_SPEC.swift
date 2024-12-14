import Foundation
import Testing
import Combine
import SharedUtils
@testable import Domain

class UseCaseCurrencyConversorTests {
    
    /// GIVEN: Base currency, rates, and amount
    /// WHEN: Calculating conversion results
    /// THEN: The conversion results should be accurate
    @Test
    func testConversionResults_usingBase_areAccurate() {
        // Given
        let selectedCurrency: String = "USD"
        let amount: Double = 100.0
        let exchangeRates = ExchangeRates(
            base: "USD",
            rates: ["EUR": 0.9, "GBP": 1.1]
        )
        
        // When
        let results: [ConversionResult] = try! UseCaseCurrencyConversor
            .calculateConversionResults(
                selectedCurrencyCode: selectedCurrency,
                amount: amount,
                exchangeRates: exchangeRates
            )
        
        // Then
        #expect(results.count == 2)
        #expect(results.contains { $0.targetCurrency == "EUR" })
        #expect(results.contains { $0.targetCurrency == "GBP" })
        #expect(results.first { $0.targetCurrency == "EUR" }!
            .convertedAmount.isEqual(to: 90.0, tolerance: 0.0001))
        #expect(results.first { $0.targetCurrency == "GBP" }!
            .convertedAmount.isEqual(to: 110.0, tolerance: 0.0001))
    }
    
    /// GIVEN: NOT Base currency, rates, and amount
    /// WHEN: Calculating conversion results
    /// THEN: The conversion results should be accurate
    @Test
    func testConversionResults_notUsingBase_areAccurate() {
        // Given
        let selectedCurrency: String = "EUR"
        let amount: Double = 100.0
        let exchangeRates = ExchangeRates(
            base: "USD",
            rates: ["EUR": 0.9, "GBP": 1.1, "USD": 1.0]
        )
        
        // When
        let results: [ConversionResult] = try! UseCaseCurrencyConversor
            .calculateConversionResults(
                selectedCurrencyCode: selectedCurrency,
                amount: amount,
                exchangeRates: exchangeRates
            )
        
        // Then
        #expect(results.count == 2)
        #expect(results.contains { $0.targetCurrency == "USD" })
        #expect(results.contains { $0.targetCurrency == "GBP" })
        #expect(results.first { $0.targetCurrency == "USD" }!
            .convertedAmount.isEqual(to: 111.11, tolerance: 0.01))
        #expect(results.first { $0.targetCurrency == "GBP" }!
            .convertedAmount.isEqual(to: 122.22, tolerance: 0.01))
    }
    
    /// GIVEN: Inexisting currency, rates, and amount
    /// WHEN: Calculating conversion results
    /// THEN: It should fail with error
    @Test
    func testConversionResults_inexistingCurrency() {
        // Given
        let selectedCurrency: String = "InexistingCurrency"
        let amount: Double = 100.0
        let exchangeRates = ExchangeRates(
            base: "USD",
            rates: ["EUR": 0.9, "GBP": 1.1]
        )
        
        // When / Then
        #expect(throws: UseCaseCurrencyConversor.Error.selectedCurrencyNotFound) {
            try UseCaseCurrencyConversor
                .calculateConversionResults(
                    selectedCurrencyCode: selectedCurrency,
                    amount: amount,
                    exchangeRates: exchangeRates
                )
        }
        
    }
    
    /// GIVEN: A negative amount
    /// WHEN: Calculating conversion results
    /// THEN: The results should be correct
    @Test
    func testConversionResults_negativeAmount() {
        // Given
        let selectedCurrency: String = "USD"
        let amount: Double = -100.0
        let exchangeRates = ExchangeRates(
            base: "USD",
            rates: ["EUR": 0.9, "GBP": 1.1]
        )
        
        // When
        let results: [ConversionResult] = try! UseCaseCurrencyConversor
            .calculateConversionResults(
                selectedCurrencyCode: selectedCurrency,
                amount: amount,
                exchangeRates: exchangeRates
            )
        
        // Then
        #expect(results.count == 2)
        #expect(results.contains { $0.targetCurrency == "EUR" })
        #expect(results.contains { $0.targetCurrency == "GBP" })
        #expect(results.first { $0.targetCurrency == "EUR" }!
            .convertedAmount.isEqual(to: -90.0, tolerance: 0.0001))
        #expect(results.first { $0.targetCurrency == "GBP" }!
            .convertedAmount.isEqual(to: -110.0, tolerance: 0.0001))
    }
    
    /// GIVEN: Valid currency, rates, and amount
    /// WHEN: Calculating conversion results
    /// THEN: The results should not contain the original currency
    @Test
    func testConversionResults_excludesOriginalCurrency() {
        // Given
        let selectedCurrency: String = "USD"
        let amount: Double = 100.0
        let exchangeRates = ExchangeRates(
            base: "USD",
            rates: ["USD": 1.0, "EUR": 0.9, "GBP": 0.8]
        )
        
        // When
        let results: [ConversionResult] = try! UseCaseCurrencyConversor
            .calculateConversionResults(
                selectedCurrencyCode: selectedCurrency,
                amount: amount,
                exchangeRates: exchangeRates
            )
        
        // Then
        #expect(!results.contains { $0.targetCurrency == "USD" })
    }
    
}

// MARK: - ExchangeRates for tests
private extension ExchangeRates {
    
    init(base: String, rates: [String : Double]) {
        self.init(
            disclaimer: "",
            license: "",
            timestamp: 0,
            base: base,
            rates: rates
        )
    }
    
}
