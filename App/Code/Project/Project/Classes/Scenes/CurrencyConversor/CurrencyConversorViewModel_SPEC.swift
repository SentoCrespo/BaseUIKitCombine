import Testing
import Combine
import Domain
import Data
@testable import Project

class CurrencyConversorViewModelTests {
    
    // MARK: - Properties
    private var cancellables: Set<AnyCancellable>!
    
    // MARK: - Life Cycle
    init() {
        cancellables = []
    }
    
    deinit {
        cancellables = nil
    }
    
}

// MARK: - Actions
extension CurrencyConversorViewModelTests {
    
    /// GIVEN: A currency is selected by the user
    /// WHEN: The user selects a currency
    /// THEN: The `selectedCurrency` in the model should be updated
    @Test
    func userSelectedCurrency_updatesModel() async {
        // Given
        let currency = "USD"
        let viewModel = setupViewModel()
        viewModel.newState {
            $0.currencies = ["USD", "EUR", "GBP"]
        }
        // When
        viewModel.userSelected(currency: currency)
        // Then
        #expect(viewModel.state.value.selectedCurrency == currency)
    }
    
    /// GIVEN: An amount entered by the user
    /// WHEN: The user enters an amount
    /// THEN: The `amount` in the model should be updated
    @Test
    func userEnteredAmount_updatesModel() async {
        // Given
        let amount = "100.0"
        let viewModel = setupViewModel()
        // When
        viewModel.userEntered(amount: amount)
        // Then
        #expect(viewModel.state.value.amount == 100.0)
    }
    
    /// GIVEN: An invalid amount entered by the user
    /// WHEN: The user enters an invalid amount
    /// The `amount` in the model should be updated to nil
    @Test
    func userEnteredAmount_invalidInput() async {
        // Given
        let amount = "InvalidNumber"
        let viewModel = setupViewModel()
        // When
        viewModel.userEntered(amount: amount)
        // Then
        #expect(viewModel.state.value.amount == nil)
    }
    
    /// GIVEN: An blank amount entered by the user
    /// WHEN: The user enters it
    /// THEN: The `amount` in the model should be updated to nil
    @Test
    func userEnteredAmount_blankInput() async {
        // Given
        let amount = " "
        let viewModel = setupViewModel()
        // When
        viewModel.userEntered(amount: amount)
        // Then
        #expect(viewModel.state.value.amount == nil)
    }
}

// MARK: - Effects
extension CurrencyConversorViewModelTests {
    
    /// GIVEN: A mock datasource with a list of exchange rates
    /// WHEN: Loading available currencies
    /// THEN: The model should be updated with the currencies
    @Test
    func loadExchangeRates_success() async {
        // Given
        let datasource = UseCaseExchangeRateDatasourceMock.test
        let viewModel = setupViewModel(datasource: datasource)
        // When
        viewModel.loadExchangeRates()
        // Then
        viewModel
            .state
            .sink(
                receiveValue: { newState in
                    #expect(newState.currencies.count == 10)
                    #expect(newState.currencies.first == "AED")
                    #expect(newState.isLoading == false)
                })
            .store(in: &cancellables)
    }
    
    /// GIVEN: A mock datasource that fails to load exchange rates
    /// WHEN: Loading available currencies
    /// THEN: The model should handle the error gracefully
    @Test
    func loadExchangeRates_failure() async {
        // Given
        let error = NSError(domain: "TestError", code: -1, userInfo: nil)
        let datasource = UseCaseExchangeRateDatasourceMock().withExchangeRates(.failure(error))
        let viewModel = setupViewModel(datasource: datasource)
        // When
        viewModel.loadExchangeRates()
        // Then
        viewModel
            .state
            .sink(
                receiveValue: { newState in
                    #expect(newState.currencies.isEmpty)
                    #expect(newState.isLoading == false)
                    #expect(newState.errorMessage == .loadingRatesFailed)
                })
            .store(in: &cancellables)
    }
    
}

// MARK: - Bindings
extension CurrencyConversorViewModelTests {
    
    /// GIVEN: All values are valid
    /// WHEN: Observing the bindings
    /// THEN: Conversion results should be calculated
    @Test
    func testConversionResults_whenAllValuesAreValid() async {
        // Given
        let viewModel = setupViewModel()
        // When
        viewModel.newState {
            $0.selectedCurrency = "USD"
            $0.amount = 100.0
            $0.currencies = ["USD", "EUR", "GBP"]
        }
        viewModel
            .state
            .sink(receiveValue: { newState in
                // Then
                #expect(newState.conversionResults.count == 9)
                #expect(newState.conversionResults.contains { $0.targetCurrency == "EUR" })
                #expect(newState.conversionResults.contains { $0.targetCurrency == "GBP" })
                
            })
            .store(in: &cancellables)
    }
    
    /// GIVEN: An existing conversion result
    /// WHEN: Changing the selected currency
    /// THEN: Conversion results should update
    @Test
    func testConversionResultsUpdate_whenCurrencyChanges() async {
        // Given
        let viewModel = setupViewModel()
        viewModel.newState {
            $0.selectedCurrency = "USD"
            $0.amount = 100.0
            $0.currencies = ["USD", "EUR", "GBP"]
        }
        // When
        viewModel.newState {
            $0.selectedCurrency = "EUR"
        }
        viewModel
            .state
            .sink(receiveValue: { newState in
                // Then
                #expect(newState.conversionResults.first(where: { $0.targetCurrency == "GBP" }) != nil)
                #expect(newState.conversionResults.find(currency: "USD") != nil)
                
            })
            .store(in: &cancellables)
    }
    
    /// GIVEN: An existing conversion result
    /// WHEN: Changing the amount
    /// THEN: Conversion results should update
    @Test
    func testConversionResultsUpdate_whenAmountChanges() async {
        // Given
        let viewModel = setupViewModel()
        viewModel.newState {
            $0.selectedCurrency = "USD"
            $0.amount = 100.0
            $0.currencies = ["USD", "EUR", "GBP"]
        }
        // When
        viewModel.newState {
            $0.amount = 200.0
        }
        viewModel
            .state
            .sink(receiveValue: { newState in
                // Then
                #expect(newState.conversionResults.find(currency: "EUR") != nil)
                #expect(newState.conversionResults.find(currency: "GBP") != nil)
                
            })
            .store(in: &cancellables)
    }
    
    /// GIVEN: Amount and selectedCurrency are nil
    /// WHEN: -
    /// THEN: The error is .noCurrencyNoAmount
    @Test
    func testErrorMessage_whenAmountAndCurrencyAreNil() async {
        // Given
        let viewModel = setupViewModel()
        // When
        viewModel.newState {
            $0.amount = nil
            $0.selectedCurrency = nil
        }
        // Then
        viewModel
            .state
            .sink(receiveValue: { newState in
                #expect(newState.errorMessage == .noCurrencyNoAmount)
            })
            .store(in: &cancellables)
    }
    
    /// GIVEN: Amount has a valid value and selectedCurrency is nil
    /// WHEN: -
    /// THEN: The error is .noCurrency
    @Test
    func testErrorMessage_whenAmountIsValidAndCurrencyIsNil() async {
        // Given
        let viewModel = setupViewModel()
        // When
        viewModel.newState {
            $0.amount = 100.0
            $0.selectedCurrency = nil
        }
        // Then
        viewModel
            .state
            .sink(receiveValue: { newState in
                #expect(newState.errorMessage == .noCurrency)
            })
        .store(in: &cancellables)
    }

    /// GIVEN: Amount is nil and there's a selectedCurrency
    /// WHEN: -
    /// THEN: The error is .noAmount
    @Test
    func testErrorMessage_whenAmountIsNilAndCurrencyIsValid() async {
        // Given
        let viewModel = setupViewModel()
        // When
        viewModel.newState {
            $0.amount = nil
            $0.selectedCurrency = "USD"
        }
        // Then
        viewModel.state.sink(receiveValue: { newState in
            #expect(newState.errorMessage == .noAmount)
        })
        .store(in: &cancellables)
    }
    
    /// GIVEN: Amount and selectedCurrency are valid
    /// WHEN: -
    /// THEN: There's no error
    @Test
    func testErrorMessage_whenBothAmountAndCurrencyAreValid() async {
        // Given
        let viewModel = setupViewModel()
        // When
        viewModel.newState {
            $0.amount = 100.0
            $0.selectedCurrency = "USD"
        }
        // Then
        viewModel
            .state
            .dropFirst()
            .sink(receiveValue: { newState in
                #expect(newState.errorMessage == nil)
            })
            .store(in: &cancellables)
    }

}

// MARK: - Private Methods
private extension CurrencyConversorViewModelTests {
    
    func setupViewModel(
        datasource: UseCaseExchangeRateDatasource = UseCaseExchangeRateDatasourceMock.test
    ) -> CurrencyConversorViewModel {
        let dependencies = CurrencyConversorDependencies(
            mainStore: AppReduxStore.mock(),
            datasource: datasource,
            persistence: UseCaseExchangeRatePersistenceMemory()
        )
        let router = CurrencyConversorRouterMock()
        router.showScene(dependencies: dependencies)
        // Simulate it loaded
        router.viewModel.onViewDidLoad()
        return router.viewModel
    }
    
}

extension Array where Element == ConversionResult {
    
    func find(currency: String) -> ConversionResult? {
        return first(where: {
            $0.targetCurrency == currency
        })
    }
    
}
