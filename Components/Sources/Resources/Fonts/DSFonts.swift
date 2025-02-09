//
//  DSFonts.swift
//  
//
//  Created by george.apostolakis on 07/02/25.
//

import SwiftUI

public enum DSFontStyle: CaseIterable {
    case header
    case title
    case subtitle
    case body
    case small
}

public extension Font {
    /// Return a Font from the Design System
    /// - Parameters:
    ///   - color: DSFontStyle value
    /// - Returns: A Font from the DS system
    static func dsFonts(_ style: DSFontStyle) -> Font {
        let fontName = "Roboto"
        switch style {
        case .header: return Font.custom(fontName, size: 28)
        case .title: return Font.custom(fontName, size: 24)
        case .subtitle: return Font.custom(fontName, size: 20)
        case .body: return Font.custom(fontName, size: 16)
        case .small: return Font.custom(fontName, size: 14)
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 25) {
            ForEach(DSFontStyle.allCases, id: \.self) {
                Text(String(describing: $0).capitalized)
                    .font(.dsFonts($0))
            }
        }
    }
    .onAppear {
        UIScrollView.appearance().bounces = false
    }
}
