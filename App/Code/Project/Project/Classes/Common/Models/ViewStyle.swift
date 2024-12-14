import UIKit

struct ViewStyle {
    public var borderColor: UIColor = .lightGray
    public var borderWidth: CGFloat = 0
    public var shadowModel: ShadowModel?
    public var backgroundColor: UIColor = UIColor.clear
}

extension ViewStyle {
    static var bordered: ViewStyle {
        var style = ViewStyle()
        style.borderWidth = 1
        style.borderColor = .lightGray
        return style
    }
    
    static var shadowed: ViewStyle {
        var style = ViewStyle()
        style.shadowModel = ShadowModel.default
        return style
    }
}

extension ViewStyle {
    
    func apply(_ view: UIView) {
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        shadowModel?.apply(layer: view.layer)
        view.backgroundColor = backgroundColor
    }
}
