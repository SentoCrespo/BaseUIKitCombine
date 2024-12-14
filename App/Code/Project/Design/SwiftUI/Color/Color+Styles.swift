import Foundation
import SwiftUI
import SharedUtils

/// Dynamic color sets (Light & Dark Mode)
/// Reference: https://airtable.com/shrHQdv9vQGz7UMQj/tblH3GqNwWSvZmrGX/viwKQnM5JrVAWzHIr
public extension Color {
    
    // Brand
    static let brandPrimary = Color("#E60012")
    
    // Contrast
    static let contrastPrimary = Color("#0A1C2A")
    static let contrastSecondary = Color("#000000")

    // Theme
    static let themePrimary = Color("#FFFFFF")
    static let themeSecondary = Color("#F2F2F2")
    
}

/// Static color sets
public extension Color {
    
    static let darkPrimary = Color("#0A1C2A")
    static let gray = Color("#F2F2F2")
    static let lightPrimary = Color("#E60012")
    
}
