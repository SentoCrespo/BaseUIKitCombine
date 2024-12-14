import Testing
import Combine
import Domain
import Data
@testable import Project

// MARK: - Router
class CurrencyConversorRouterMock {
    
    // MARK: - Properties
    var viewModel: CurrencyConversorViewModel!
    
    // MARK: - Life Cycle
    init() {}
    
}
 
extension CurrencyConversorRouterMock: CurrencyConversorRouterProtocol {

    func showScene(dependencies: CurrencyConversorDependencies) {
        
        let view = CurrencyConversorViewMock()
        let viewModel = CurrencyConversorViewModel(
            dependencies: dependencies,
            view: view
        )
        self.viewModel = viewModel
        view.setup(viewModel: viewModel)
    }
    
}

// MARK: - View
class CurrencyConversorViewMock: CurrencyConversorViewProtocol {
    
    var viewModel: CurrencyConversorViewModel!
    
    init() {}
    
    func setup(viewModel: CurrencyConversorViewModel) {
        self.viewModel = viewModel
    }
    
    func fill(currencies: [String]) {}
    
    func fill(conversions: [Domain.ConversionResult]) {}
    
    func fill(amount: String?) {}
    
    func show(error: CurrencyConversorModel.Error?) {}
    
    func show(loading: Bool) {}
    
}

// MARK: - Datasource
extension UseCaseExchangeRateDatasourceMock {
    
    static var test: UseCaseExchangeRateDatasource {
        let exchangeRate = ExchangeRates.test
        return UseCaseExchangeRateDatasourceMock().withExchangeRates(.success(exchangeRate))
    }
    
}

// MARK: - Models
extension ExchangeRates {
    
    static var test: ExchangeRates {
        return .init(
            disclaimer: "https://openexchangerates.org/terms/",
            license: "https://openexchangerates.org/license/",
            timestamp: 1449877801,
            base: "USD",
            rates: [
                "AED": 3.672538,
                "AFN": 66.809999,
                "ALL": 125.716501,
                "AMD": 484.902502,
                "ANG": 1.788575,
                "AOA": 135.295998,
                "ARS": 9.750101,
                "USD": 1.0,
                "EUR": 0.895433,
                "GBP": 0.779999
            ]
        )
    }
}
