import Foundation
import SwiftUI

public extension Text {
    
    static func largeTitle(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.largeTitle)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func title1(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.title1)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func title2(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.title2)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func title3(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.title3)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func headline(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.headline)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func body(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.body)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func subheadline(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: Typography.FontFamily.helveticaNeueSemiBold,
                size: Typography.FontSize.subhead)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func callout(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.callout)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func footnote(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.callout)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func caption1(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.caption1)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func caption2(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: Typography.FontFamily.helveticaNeue,
                size: Typography.FontSize.caption2)
            .foregroundColor(Color.themePrimary)
        return result
    }

}
