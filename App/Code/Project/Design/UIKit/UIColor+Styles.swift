import Foundation
import UIKit

/// Dynamic color sets (Light & Dark Mode)
/// Reference: https://airtable.com/shrHQdv9vQGz7UMQj/tblH3GqNwWSvZmrGX/viwKQnM5JrVAWzHIr
public extension UIColor {
    
    // Brand
    static let brandPrimary = UIColor(hex: "#E60012")!
    
    // Contrast
    static let contrastPrimary = UIColor(hex: "#0A1C2A")!
    static let contrastSecondary = UIColor(hex: "#000000")!

    // Theme
    static let themePrimary = UIColor(hex: "#FFFFFF")!
    static let themeSecondary = UIColor(hex: "#F2F2F2")!
    
}

/// Static color sets
public extension UIColor {
    
    static let darkPrimary = UIColor(hex: "#0A1C2A")!
    static let gray = UIColor(hex: "#F2F2F2")!
    static let lightPrimary = UIColor(hex: "#E60012")!
    
}
