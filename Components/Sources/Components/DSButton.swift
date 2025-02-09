//
//  DSButton.swift
//
//
//  Created by george.apostolakis on 08/02/25.
//

import SwiftUI

public struct DSButton: View {

    private let variant: Variant
    private let title: String
    @Binding private var isLoading: Bool
    @Binding private var isDisable: Bool
    private let action: () -> Void

    /// Creates a customizable DSButton.
    ///
    /// - Parameters:
    ///   - title: The text displayed on the button.
    ///   - variant: The style variant of the button, default is `.fill`.
    ///   - isLoading: for  controlling the  loading state of the button. Default is `.constant(false)`.
    ///   - isDisable: for  controlling disable state of the button. Default is `.constant(false)`.
    ///   - action: A closure to be executed when the button is pressed.
    init(
        title: String,
        variant: Variant = .fill,
        isLoading: Binding<Bool> = .constant(false),
        isDisable: Binding<Bool> = .constant(false),
        action: @escaping () -> Void
    ) {
        self.variant = variant
        self.title = title
        _isLoading = isLoading
        _isDisable = isDisable
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            ZStack {
                buttonBody
                    .opacity(isLoading ? 0 : 1)
                loadingView
                    .opacity(isLoading ? 1 : 0)
            }
        }
        .disabled(isDisable || isLoading)
    }

    @ViewBuilder
    private var buttonBody: some View {
        if isDisable {
            DSText(title, variant: .title, textColor: variant.disableTextColor)
                .padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background(variant.disableBackgroundColor)
                .cornerRadius(25)
        } else {
            DSText(title, variant: .title, textColor: variant.textColor)
                .padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background(variant.backgroundColor)
                .cornerRadius(25)
        }
    }

    private var loadingView: some View {
        ProgressView()
            .opacity(isLoading ? 1 : 0)
    }
}

public extension DSButton {
    enum Variant {
        case fill
        case text

        var textColor: DSColor {
            switch self {
            case .fill: return .reverseColor
            case .text: return .primary
            }
        }

        var backgroundColor: Color {
            switch self {
            case .fill: return Color.dsColor(.contrast)
            case .text: return Color.dsColor(.clear)
            }
        }

        var disableTextColor: DSColor {
            switch self {
            case .fill, .text: return .reverseColor
            }
        }

        var disableBackgroundColor: Color {
            switch self {
            case .fill: return Color.dsColor(.lightContrast)
            case .text: return Color.dsColor(.clear)
            }
        }
    }
}

#Preview {
    VStack {
        DSButton(title: "Fill") {}
        DSButton(title: "Text", variant: .text) {}
        DSButton(title: "isLoading", variant: .text, isLoading: .constant(true)) {}
        DSButton(title: "isDisable and Fill", isDisable: .constant(true)) {}
        DSButton(title: "isDisable and Text", variant: .text, isDisable: .constant(true)) {}
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
