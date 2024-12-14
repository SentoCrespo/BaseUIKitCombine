import Foundation
import UIKit

public extension String {
    func attributedWith(color: UIColor) -> NSMutableAttributedString {
        let result = NSMutableAttributedString(
            string: self,
            attributes: [
                NSAttributedString.Key.foregroundColor: color
            ]
        )
        return result
    }
}
