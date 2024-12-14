import Foundation
import UIKit

class LabelError: UILabel {
    
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

private extension LabelError {
    
    func configure() {
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 12, weight: .regular)
        textColor = .red
        backgroundColor = .themePrimary
    }
    
}
