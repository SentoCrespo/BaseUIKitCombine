import Foundation
import UIKit
import Combine
import Domain
import Design

protocol CurrencyConversorViewProtocol: AnyObject {
    func setup(viewModel: CurrencyConversorViewModel)
    func fill(currencies: [String])
    func fill(conversions: [ConversionResult])
    func fill(amount: String?)
    func show(error: CurrencyConversorModel.Error?)
    func show(loading: Bool)
}

class CurrencyConversorView: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var textAmount: UITextField!
    @IBOutlet private weak var textCurrency: UITextField!
    @IBOutlet private weak var listConversions: UITableView!
    @IBOutlet private weak var labelError: UILabel!
    @IBOutlet private var viewLoading: UIView!
    private let currencyPicker = UIPickerView()
    
    // MARK: - Properties
    var viewModel: CurrencyConversorViewModel?
    private var cancellables = Set<AnyCancellable>()
    private var currencies: [String] {
        let currencies = viewModel?.state.value.currencies ?? []
        return currencies
    }
    
    deinit {}
    
}

// MARK: - View Life Cycle
extension CurrencyConversorView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel?.onViewDidLoad()
    }
    
    func setupUI() {
        setupAmountTextfield()
        setupCurrencyPicker()
        setupConversionsList()
        setupErrorLabel()
    }
        
    @objc private func dismissPicker() {
        let selectedIndex = currencyPicker.selectedRow(inComponent: 0)
        self.selectCurrency(index: selectedIndex)
        textCurrency.resignFirstResponder()
    }
    
}

// MARK: - Accessible methods
extension CurrencyConversorView: CurrencyConversorViewProtocol {
    
    func setup(viewModel: CurrencyConversorViewModel) {
        self.viewModel = viewModel
    }
    
    func fill(amount: String?) {
        textAmount.text = amount
    }
    
    func fill(currencies: [String]) {
        currencyPicker.reloadAllComponents()
    }
    
    func fill(conversions: [Domain.ConversionResult]) {
        listConversions.reloadData()
    }
    
    func show(error: CurrencyConversorModel.Error?) {
        guard let error = error else {
            labelError.text = nil
            return
        }
        let message: String
        switch error {
            case .noAmount:
                message = "Insert an amount"
            case .invalidAmount:
                message = "Amount is invalid"
            case .noCurrencyNoAmount:
                message = "Insert an amount and select a currency"
            case .noCurrency:
                message = "Select a currency"
            case .loadingRatesFailed:
                message = "Could not load exchange rates"
                
        }
        labelError.text = message
    }
    
    func show(loading: Bool) {
        if loading {
            viewLoading.isHidden = false
        } else {
            viewLoading.isHidden = true
        }
    }
    
}

// MARK: - Private Methods
private extension CurrencyConversorView {
    
    func setupAmountTextfield() {
        // UI
        textAmount.placeholder = "# ### ###.##"
        textAmount.delegate = self
        // Update changes
        textAmount
            .textDidChange
            .sink { [weak self] text in
                self?.viewModel?.userEntered(amount: text)
            }
            .store(in: &cancellables)
    }
    
    func setupCurrencyPicker() {
        // UI
        textCurrency.placeholder = "- - -"
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        textCurrency.inputView = currencyPicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: 44
        )
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(dismissPicker)
        )
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        textCurrency.inputAccessoryView = toolbar
        textCurrency.delegate = self
    }
    
    func setupConversionsList() {
        // UI
        listConversions.delegate = self
        listConversions.dataSource = self
        let nib = UINib(nibName: "ConversionResultCell", bundle: nil)
        listConversions.register(nib, forCellReuseIdentifier: "Cell")
        listConversions.allowsSelection = false
    }
    
    func setupErrorLabel() {
        labelError.textColor = .red
    }
}

// MARK: - Textfield
extension CurrencyConversorView: UITextFieldDelegate {
    
    // swiftlint:disable:next line_length
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Currency
        if textField == textCurrency {
            return false
        }
        // Amount
        if textField == textAmount {
            guard let text = textField.text else {
                return true
            }
            
            let newLength = text.count + string.count - range.length
            if newLength >= Constants.maximumCharactersInAmount {
                return false
            }
            // EXT-06: Read Improvements.md
            return true
        }
        // Default
        return true
    }
    
}

// MARK: - PickerView
extension CurrencyConversorView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectCurrency(index: row)
    }
    
    func selectCurrency(index: Int) {
        let selectedCurrency = currencies[index]
        viewModel?.userSelected(currency: selectedCurrency)
        textCurrency.text = selectedCurrency
    }
    
}

// MARK: - TableView
extension CurrencyConversorView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.state.value.conversionResults.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: ConversionResultCell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        ) as? ConversionResultCell else {
            fatalError("No cell to dequeue 'ConversionResultCell'")
        }
        guard let item = viewModel?.state.value.conversionResults[indexPath.row] else {
            fatalError("No item found for cell item '\(indexPath.row)'")
        }
        cell.fill(item: item)
        return cell
    }
    
}
