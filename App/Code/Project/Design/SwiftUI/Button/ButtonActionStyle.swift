import Foundation
import SwiftUI

public struct ButtonActionStyle: ButtonStyle {
    
    // MARK: - Life Cycle
    public init() {}
    
}
    
public extension ButtonActionStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.button)
            .foregroundColor(configuration.isPressed ? Color.themeSecondary : Color.themePrimary)
            .padding()
            .background(Color.clear)
    }
    
}
