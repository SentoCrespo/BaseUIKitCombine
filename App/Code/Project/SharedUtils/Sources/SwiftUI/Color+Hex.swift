import Foundation
import SwiftUI

public extension Color {
    
    init(red: Int, green: Int, blue: Int) {
        let uiColor = UIColor(red: red, green: green, blue: blue)
        self.init(uiColor: uiColor)
    }
    
    init(hex: Int) {
        let uiColor = UIColor(hex: hex)
        self.init(uiColor: uiColor)
    }
    
    init?(hex: String) {
        guard let uiColor = UIColor(hex: hex) else {
            return nil
        }
        self.init(uiColor: uiColor)
    }
    
    func hexString(withAlpha: Bool = false) -> String? {
        let uiColor = UIColor(self)
        return uiColor.hexString(withAlpha: withAlpha)
    }
    
}


