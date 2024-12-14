import Foundation
import UIKit

public extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let imageColored = image(with: color)
        self.setBackgroundImage(imageColored, for: state)
    }
}

private extension UIButton {
    func image(with color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
