//
//  File.swift
//  
//
//  Created by george.apostolakis on 07/02/25.
//

import SwiftUI

public enum DSFontStyle {
    case header
    case title
    case subtitle
    case body
    case small
}

public extension Font {
    static func dsFonts(_ style: DSFontStyle) -> Font {
        let fontName = "Roboto"
        switch style {
        case .header: return Font.custom(fontName, size: 28)
        case .title: return Font.custom(fontName, size: 24)
        case .subtitle: return Font.custom(fontName, size: 20)
        case .body: return Font.custom(fontName, size: 14)
        case .small: return Font.custom(fontName, size: 10)
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        Text("Header")
            .font(.dsFonts(.header))
        Text("Title")
            .font(.dsFonts(.title))
        Text("Subtitle")
            .font(.dsFonts(.subtitle))
        Text("Body")
            .font(.dsFonts(.body))
        Text("Small")
            .font(.dsFonts(.small))
    }
}
