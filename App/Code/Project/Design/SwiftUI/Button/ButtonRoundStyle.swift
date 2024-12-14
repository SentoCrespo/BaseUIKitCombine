import Foundation
import SwiftUI

public struct ButtonRoundStyle: ButtonStyle {
    
    // MARK: - Life Cycle
    public init() {}
    
}

public extension ButtonRoundStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        let size: CGFloat = 64.0
        return configuration
            .label
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.button)
            .foregroundColor(configuration.isPressed ? Color.contrastSecondary : Color.brandPrimary)
            .padding()
            .background(configuration.isPressed ? Color.brandPrimary : Color.contrastSecondary)
            .frame(width: size, height: size, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: size))
            .overlay(RoundedRectangle(cornerRadius: size)
                .stroke(Color.darkPrimary, lineWidth: 1))
    }
    
}
