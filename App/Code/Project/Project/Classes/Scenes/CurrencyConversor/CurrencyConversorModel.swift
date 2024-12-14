import Foundation
import Combine
import Domain

/// Domain definition for the scene
struct CurrencyConversorModel {
    // MARK: - Properties
    // Data
    var exchangeRates: ExchangeRates?
    var currencies: [String]
    var conversionResults: [ConversionResult]
    // User
    var selectedCurrency: String?
    var amount: Double?
    // UI
    var isLoading: Bool
    var errorMessage: Self.Error?
}
extension CurrencyConversorModel: Equatable & Hashable {}

extension CurrencyConversorModel {
    
    static var initial: CurrencyConversorModel {
        return CurrencyConversorModel(
            exchangeRates: nil,
            currencies: [],
            conversionResults: [],
            selectedCurrency: nil,
            amount: nil,
            isLoading: false,
            errorMessage: nil
        )
    }
    
}

extension CurrencyConversorModel {
    
    enum Error: Swift.Error {
        case noCurrencyNoAmount
        case noCurrency
        case noAmount
        case invalidAmount
        case loadingRatesFailed
    }
    
}

extension CurrencyConversorModel {
    
    struct ConversionInput {
        
        // MARK: - Properties
        let selectedCurrency: String
        let amount: Double
        let exchangeRates: ExchangeRates
        
        // MARK: - Life Cycle
        init?(selectedCurrency: String?, amount: Double?, exchangeRates: ExchangeRates?) {
            guard let selectedCurrency = selectedCurrency else {
                return nil
            }
            guard let amount = amount else {
                return nil
            }
            guard let exchangeRates = exchangeRates else {
                return nil
            }
            self.selectedCurrency = selectedCurrency
            self.amount = amount
            self.exchangeRates = exchangeRates
        }
        
    }
    
}

extension CurrencyConversorModel.ConversionInput: Hashable & Equatable {}
