import Foundation
import UIKit
import Domain
import Design

class ConversionResultCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.backgroundColor = .themePrimary
        
        currencyLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        currencyLabel.textColor = .contrastPrimary
        currencyLabel.numberOfLines = 0
        
        valueLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        valueLabel.textColor = .contrastPrimary
        valueLabel.numberOfLines = 1
        valueLabel.textAlignment = .right
    }
    
    // MARK: - Configuration
    func fill(item: ConversionResult) {
        currencyLabel.text = item.targetCurrency
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        let formattedAmount = formatter.string(
            from: NSNumber(value: item.convertedAmount)
        )
        valueLabel.text = formattedAmount
    }
    
}
