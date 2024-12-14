import Foundation
import UIKit

public extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
    
    convenience init?(hex: String) {
        // Convert hex string to an integer
        let hexint = Int64(UIColor.intFromHexString(hex: hex))
        
        let hexSanitized = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        if hexSanitized.count == 6 {
            let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
            let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
            let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
            let alpha: CGFloat = 1.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
            return
        } else if hexSanitized.count == 8 {
            let red = CGFloat((hexint & 0xff000000) >> 24) / 255.0
            let green = CGFloat((hexint & 0xff0000) >> 16) / 255.0
            let blue = CGFloat((hexint & 0xff00) >> 8) / 255.0
            let alpha = CGFloat(hexint & 0xff) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
            return
        }
        
        return nil
    }
}

public extension UIColor {
    
    func hexString(withAlpha: Bool = false) -> String? {
        guard let components = self.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        // Alpha Channel
        if withAlpha == true {
            return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            // No alpha channel
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}

private extension UIColor {
    
    static func intFromHexString(hex: String) -> UInt64 {
        // Sanitize string
        var hexFormatted: String = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        // Skip the # character
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        // Scan hex value
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        return rgbValue
    }
    
}
