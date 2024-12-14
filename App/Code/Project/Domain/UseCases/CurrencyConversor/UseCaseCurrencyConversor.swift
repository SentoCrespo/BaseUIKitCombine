import Foundation

public enum UseCaseCurrencyConversor {

    // MARK: - Domain Errors
    public enum Error: Swift.Error, LocalizedError {
        case selectedCurrencyNotFound
        
        public var errorDescription: String? {
            switch self {
                case .selectedCurrencyNotFound:
                    return "The selected currency was not found in the exchange rates."
            }
        }
    }
    
    public static func calculateConversionResults(
        selectedCurrencyCode: String,
        amount: Double,
        exchangeRates: ExchangeRates
    ) throws -> [ConversionResult] {
        
        // Pre-conditions
        // Selected currency should be the base curency
        // or exchange rates should contain the selected currency
        let isBaseCurrency = selectedCurrencyCode == exchangeRates.base
        let selectedRate = exchangeRates.rates[selectedCurrencyCode]
        let isContainedInExchangeRates = selectedRate != nil
        guard isBaseCurrency || isContainedInExchangeRates else {
            throw Error.selectedCurrencyNotFound
        }
        
        // Calculate conversion with given amount
        var result = exchangeRates
            .rates
            .compactMap { rate -> ConversionResult? in
                let convertedAmount: Double
                // Direct conversion from base currency
                if selectedCurrencyCode == exchangeRates.base {
                    convertedAmount = amount * rate.value
                } else {
                    // Conversion through the base currency
                    convertedAmount = (amount / selectedRate!) * rate.value
                }
                return ConversionResult(
                    targetCurrency: rate.key,
                    convertedAmount: convertedAmount
                )
            }
            // Remove exchange rate for the seleced currency as it's redundant
            .filter { conversionResult in
                return conversionResult.targetCurrency != selectedCurrencyCode
            }
            // Sort alphabetically by currency, ascending
            .sorted(by: {
                $0.targetCurrency < $1.targetCurrency
            })
        return result
    }
    
}
