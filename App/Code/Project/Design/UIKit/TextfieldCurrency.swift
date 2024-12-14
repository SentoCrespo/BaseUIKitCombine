import Foundation
import UIKit

class TextFieldDropdown: UITextField {
    
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

private extension TextFieldDropdown {
    
    func configure() {
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textColor = .contrastPrimary
        borderStyle = .none
        layer.cornerRadius = 10
        backgroundColor = .blue.withAlphaComponent(0.3)
    }
    
}
