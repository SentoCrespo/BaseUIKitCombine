import Foundation
import UIKit

public struct BorderModel {
    public var color: UIColor = .lightGray
    public var width: CGFloat = 0
    
    static var `default`: BorderModel {
        return BorderModel()
    }
}

extension BorderModel {
    
    func apply(view: UIView) {
        self.apply(layer: view.layer)
    }
    
    func apply(layer: CALayer) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
