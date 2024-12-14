import Foundation
import UIKit

public extension UIImageView {
    func with(tintColor: UIColor) {
        let image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = tintColor
        self.image = image
    }
}
