import Foundation
import SwiftUI

public struct Typography {

    public struct FontSize {
        static let largeTitle: CGFloat = 34.0
        static let title1: CGFloat = 28.0
        static let title2: CGFloat = 22.0
        static let title3: CGFloat = 20.0
        static let headline: CGFloat = 17.0
        static let body: CGFloat = 17.0
        static let callout: CGFloat = 16.0
        static let subhead: CGFloat = 15.0
        static let footnote: CGFloat = 13.0
        static let caption1: CGFloat = 12.0
        static let caption2: CGFloat = 11.0
        
        static let button: CGFloat = 20.0
    }
    
    public enum FontFamily: String {
        case helveticaNeue = "HelveticaNeue"
        case helveticaNeueSemiBold = "HelveticaNeue-SemiBold"
        case helveticaNeueBold = "HelveticaNeue-Bold"
        case georgia = "Georgia"
    }
    
}

// Apple's definitions
// 
// Large Title     Regular    34
// Title 1         Regular    28
// Title 2         Regular    22
// Title 3         Regular    20
// Headline        Semi-Bold  17
// Body            Regular    17
// Callout         Regular    16
// Subhead         Regular    15
// Footnote        Regular    13
// Caption 1       Regular    12
// Caption 2       Regular    11
