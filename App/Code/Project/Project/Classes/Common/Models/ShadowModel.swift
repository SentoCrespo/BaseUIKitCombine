import Foundation
import UIKit

public struct ShadowModel {
    public var color: UIColor = UIColor.darkGray
    public var size: CGSize = CGSize(width: 1, height: 1)
    public var radius: CGFloat = 3
    public var opacity: CGFloat = 0.3
    
    static var `default`: ShadowModel {
        return ShadowModel()
    }
}

extension ShadowModel {
    
    func apply(view: UIView) {
        self.apply(layer: view.layer)
    }
    
    func apply(layer: CALayer) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = size
        layer.shadowOpacity = Float(opacity)
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}
