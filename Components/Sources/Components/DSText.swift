//
//  DSText.swift
//  
//
//  Created by george.apostolakis on 07/02/25.
//

import Core
import SwiftUI

public struct DSText: View {
    private let string: String
    private let variant: DSFontStyle
    private let textColor: DSColor

    /// Creates a customizable DSText.
    ///
    /// - Parameters:
    ///   - string: The text displayed on the button.
    ///   - variant: The font style variant, default is `.body`.
    ///   - textColor: The color of the font, default is `.primary`.
    public init(_ string: String = "", variant: DSFontStyle = .body, textColor: DSColor = .primary) {
        self.string = string
        self.variant = variant
        self.textColor = textColor
    }

    public var body: some View {
        Text(string)
            .foregroundStyle(Color.dsColor(textColor))
            .font(.dsFonts(variant))
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
    }
}

#Preview {
    List {
        VStack {
            ForEach(DSFontStyle.allCases, id: \.self) { font in
                ForEach(DSColor.allCases, id: \.self) { color in
                    DSText(
                        "Font: \(String(describing: font)) & Color: \(String(describing: color))",
                        variant: font,
                        textColor: color
                    )
                    .padding(.vertical)
                }
            }
        }
    }
}
