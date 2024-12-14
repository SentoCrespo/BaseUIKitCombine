import Foundation
import UIKit

public class TextFieldAmount: UITextField {
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
}

private extension TextFieldAmount {
    
    func configure() {
        keyboardType = .decimalPad
        textAlignment = .right
        font = UIFont.systemFont(ofSize: 24, weight: .medium)
        textColor = .contrastPrimary
        borderStyle = .none
        backgroundColor = .themePrimary
    }
    
}
