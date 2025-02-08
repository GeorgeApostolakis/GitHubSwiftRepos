//
//  DSColor.swift
//
//
//  Created by george.apostolakis on 08/02/25.
//

import SwiftUI

// Colors selected using this tool: https://coolors.co/1b264f-274690-576ca8-302b27-f5f3f5

public enum DSColor: CaseIterable {
    case primary
    case reverseColor
    case lightContrast
    case contrast
    case darkContrast
}

public extension Color {
    /// Return a Color from the Design System
    /// - Parameters:
    ///   - color: DSColor value
    /// - Returns: A Color from the DS system
    static func dsColor(_ color: DSColor) -> Color {
        switch color {
        case .primary: return .init(red: 48/255, green: 43/255, blue: 39/255)
        case .reverseColor: return .init(red: 245/255, green: 243/255, blue: 245/255)
        case .lightContrast: return .init(red: 87/255, green: 108/255, blue: 168/255)
        case .contrast: return .init(red: 39/255, green: 70/255, blue: 144/255)
        case .darkContrast: return .init(red: 27/255, green: 38/255, blue: 79/255)
        }
    }
}

#Preview {
    ScrollView {
        VStack {
            ForEach(DSColor.allCases, id: \.self) {
                Text(String(describing: $0).capitalized)
                Color.dsColor($0)
                    .frame(maxWidth: .infinity, idealHeight: 40)
            }
        }
    }
    .onAppear {
        UIScrollView.appearance().bounces = false
    }
}
