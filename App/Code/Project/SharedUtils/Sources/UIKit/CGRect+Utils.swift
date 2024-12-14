import UIKit

public extension CGRect {
    var aspectRatio: CGFloat? {
        guard size.height > 0 else { return nil }
        
        return size.width / size.height
    }
}
