import Foundation
import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
/// Handles font accessibility changes with custom fonts
///
/// Code Sample:
/// ```
/// Text("Hello World")
///     .scaledFont(name: "Georgia", size: 12)
/// ```
 
public struct ScaledFont: ViewModifier {
    
    // MARK: - Properties
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat
    
}

// MARK: - Public Methods
public extension ScaledFont {

    /// Scales the font taking care about font metric
    /// `.scaledFont(name: "Georgia", size: 12)`
    /// Instead of: `.modifier(ScaledFont(name: "Georgia", size: 12))`
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
    
}

// MARK: - Utiliy extension
@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
public extension View {
    
    /// Applies the modifier for the font
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
    
    /// Applies the modifier for the font with a specific size
    func scaledFont(name: Typography.FontFamily, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name.rawValue, size: size))
    }
    
}
