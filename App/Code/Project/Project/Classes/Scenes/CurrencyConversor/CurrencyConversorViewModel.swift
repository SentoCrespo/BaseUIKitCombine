import Foundation
import Combine
import Domain
import SharedUtils

/// Binding between UI and business logic
class CurrencyConversorViewModel: StoreCombine {
    
    // MARK: - Properties
    private weak var view: CurrencyConversorViewProtocol?
    private let dependencies: CurrencyConversorDependencies
    private var cancellables: Set<AnyCancellable>
    typealias ModelState = CurrencyConversorModel
    var state: CurrentValueSubject<CurrencyConversorModel, Never>
    
    // MARK: - Life Cycle
    init(dependencies: CurrencyConversorDependencies, view: CurrencyConversorViewProtocol) {
        self.dependencies = dependencies
        self.cancellables = []
        self.view = view
        self.state = .init(.initial)
    }
    
    deinit {
        cancellables.removeAll()
    }
    
}

// MARK: - Actions (User input)
extension CurrencyConversorViewModel {
    
    func onViewDidLoad() {
        setupBindings()
        loadExchangeRates()
    }
    
    func userSelected(currency: String) {
        newState { $0.selectedCurrency = currency }
    }
    
    func userEntered(amount: String?) {
        let amountSanitized = amount?.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let amount = amountSanitized, !amount.isEmpty else {
            newState { $0.amount = nil }
            newState { $0.conversionResults = [] }
            return
        }
        guard let amountNumber = Double(amount) else {
            newState { $0.amount = nil }
            newState { $0.errorMessage = .invalidAmount }
            newState { $0.conversionResults = [] }
            return
        }
        newState { $0.errorMessage = nil }
        newState { $0.amount = amountNumber }
    }
    
}

// MARK: - Effects (Logic output)
extension CurrencyConversorViewModel {
    
    func loadExchangeRates(date: Date = Date()) {
        UseCaseExchangeRate
            .fetchRates(
                datasource: dependencies.datasource,
                persistence: dependencies.persistence,
                currentDate: date
            )
            .receiveTestByPass(on: DispatchQueue.main)
            .sink(
                receiveSubscription: { [weak self] _ in
                    self?.newState { $0.isLoading = true }
                },
                receiveValue: { [weak self] exchangeRates in
                    self?.newState { $0.exchangeRates = exchangeRates }
                },
                receiveError: { [weak self] _ in
                    self?.newState { $0.errorMessage = .loadingRatesFailed }
                },
                receiveCompletion: { [weak self] _ in
                    self?.newState { $0.isLoading = false }
                }
            )
            .store(in: &cancellables)
    }
    
}

// MARK: - Private Methods
private extension CurrencyConversorViewModel {
    
    /// Listen for model changes to trigger logic
    func setupBindings() {
        // To state
        bindExchangeRatesToCurrencies()
        bindChangesToConversionResults()
        // To view
        bindCurrenciesToView()
        bindErrorsToView()
        bindLoadingToView()
        bindConversionResultsToView()
    }
    
    func bindExchangeRatesToCurrencies() {
        self.getChanges { $0.exchangeRates }
            .compactMap { $0 }
            .map { $0.currencies }
            .receiveTestByPass(on: DispatchQueue.main)
            .sink { [weak self] currencies in
                self?.newState { $0.currencies = currencies }
            }
            .store(in: &cancellables)
    }
    
    func bindCurrenciesToView() {
        self.getChanges { $0.currencies }
            .receiveTestByPass(on: DispatchQueue.main)
            .sink { [weak self] currencies in
                self?.view?.fill(currencies: currencies)
            }
            .store(in: &cancellables)
    }
    
    func bindErrorsToView() {
        Publishers
            .CombineLatest(
                self.getChanges { $0.amount },
                self.getChanges { $0.selectedCurrency }
            )
            .receiveTestByPass(on: DispatchQueue.main)
            .sink { [weak self] amount, selectedCurrency in
                switch (amount, selectedCurrency) {
                case (nil, nil):
                        self?.newState { $0.errorMessage = .noCurrencyNoAmount }
                case (_, nil):
                        self?.newState { $0.errorMessage = .noCurrency }
                case (nil, _):
                        self?.newState { $0.errorMessage = .noAmount }
                case (_, _):
                        self?.newState { $0.errorMessage = nil }
                }
            }
            .store(in: &cancellables)
        
        self.getChanges { $0.errorMessage }
            .receiveTestByPass(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.view?.show(error: error)
            }
            .store(in: &cancellables)
    }
    
    func bindLoadingToView() {
        self.getChanges { $0.isLoading }
            .receiveTestByPass(on: DispatchQueue.main)
            .sink { [weak self] loading in
                self?.view?.show(loading: loading)
            }
            .store(in: &cancellables)
    }
    
    func bindConversionResultsToView() {
        self.getChanges { $0.conversionResults }
            .receiveTestByPass(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.view?.fill(conversions: $0)
            })
            .store(in: &cancellables)
    }
    
    func bindChangesToConversionResults() {
        Publishers
            .CombineLatest3(
                self.getChanges { $0.selectedCurrency },
                self.getChanges { $0.amount },
                self.getChanges { $0.exchangeRates }
            )
            // Remove nil values
            .compactMap { selectedCurrency, amount, exchangeRates in
                return CurrencyConversorModel.ConversionInput(
                    selectedCurrency: selectedCurrency,
                    amount: amount,
                    exchangeRates: exchangeRates
                )
            }
            // Calculate the conversion
            .map { (conversionInput: CurrencyConversorModel.ConversionInput) -> [ConversionResult] in
                let conversionResult = try? UseCaseCurrencyConversor
                    .calculateConversionResults(
                        selectedCurrencyCode: conversionInput.selectedCurrency,
                        amount: conversionInput.amount,
                        exchangeRates: conversionInput.exchangeRates
                    )
                return conversionResult ?? []
            }
            .receiveTestByPass(on: DispatchQueue.main)
            // Process result
            .sink(receiveValue: { [weak self] conversionResults in
                self?.newState { $0.conversionResults = conversionResults }
            })
            .store(in: &cancellables)
    }
    
}
