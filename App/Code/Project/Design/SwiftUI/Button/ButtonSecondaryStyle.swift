import Foundation
import SwiftUI

public struct ButtonSecondaryStyle: ButtonStyle {
    
    // MARK: - Life Cycle
    public init() {}
    
}

public extension ButtonSecondaryStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.button)
            .foregroundColor(configuration.isPressed ? Color.themeSecondary : Color.themePrimary)
            .padding()
            .background(configuration.isPressed ? Color.brandPrimary : Color.contrastSecondary)
            .cornerRadius(4)
    }
    
}
