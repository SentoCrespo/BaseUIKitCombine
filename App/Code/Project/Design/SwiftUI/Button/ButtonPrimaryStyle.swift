import Foundation
import SwiftUI

public struct ButtonPrimaryStyle: ButtonStyle {
    
    // MARK: - Life Cycle
    public init() {}
    
}

public extension ButtonPrimaryStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.button)
            .foregroundColor(configuration.isPressed ? Color.themePrimary : Color.themeSecondary)
            .padding()
            .background(configuration.isPressed ? Color.brandPrimary : Color.contrastPrimary)
            .cornerRadius(4)
    }
    
}
