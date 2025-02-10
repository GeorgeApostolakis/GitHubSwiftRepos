//
//  DSErrorView.swift
//  
//
//  Created by george.apostolakis on 07/02/25.
//

import SwiftUI

/// `DSErrorView` is a view designed to represent error states.
///
/// This view displays the error message, an error image and provides an optional retry action button.
///
/// - Parameters:
///   - errorModel: Model containing the Error State Info and retry action.
public struct DSErrorView: View {
    private let errorModel: Model
    
    public init(errorModel: Model) {
        self.errorModel = errorModel
    }

    public var body: some View {
        VStack {
            VStack(spacing: 15) {
                errorModel.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color.dsColor(.lightContrast))
                DSText(errorModel.title, variant: .header, textColor: .primary)
                    .multilineTextAlignment(.center)
                DSText(errorModel.subtitle, variant: .body)
            }
            .padding()
            .border(Color.dsColor(.primary), width: 0.5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            if let retryAction = errorModel.retryAction {
                DSButton(title: DSStrings.ErrorView.retryButton) {
                    retryAction()
                }
                .frame(maxWidth: .infinity, alignment: .bottom)
            }
        }
        .padding()
        .background(Color.dsColor(.reverseColor))
    }
}

// MARK: - Model
public extension DSErrorView {
    enum Model {
        case generic(Image, String, (() -> Void)?)
        case badRequest(String, (() -> Void)?)
        case connection((() -> Void)?)

        var image: Image {
            switch self {
            case let .generic(image, _, _): image
            case .badRequest: Image.badRequest
            case .connection: Image.noConnection
            }
        }

        var title: String {
            switch self {
            case .generic: DSStrings.ErrorView.genericTitle
            case .badRequest: DSStrings.ErrorView.badRequestTitle
            case .connection: DSStrings.ErrorView.connectionTitle
            }
        }

        var subtitle: String {
            switch self {
            case let .generic(_, string, _): string
            case let .badRequest(string, _): string
            case .connection: DSStrings.ErrorView.connectionSubTitle
            }
        }

        var retryAction: (() -> Void)? {
            switch self {
            case let .generic(_, _, retryAction): return retryAction
            case let .badRequest(_, retryAction): return retryAction
            case let .connection(retryAction): return retryAction
            }
        }
    }
}

// MARK: - Preview
#Preview("Generic") {
    DSErrorView(
        errorModel: .generic(
            Image.negativeFeedback,
            "Some generic description about an generic error",
            { }
        )
    )
        .frame(width: .infinity, height: .infinity)
}

#Preview("BadRequest") {
    DSErrorView(errorModel: .badRequest("Some description about the error", {}))
        .frame(width: .infinity, height: .infinity)
}

#Preview("Connection") {
    DSErrorView(errorModel: .connection({}))
        .frame(width: .infinity, height: .infinity)
}

#Preview("BadRequestWithoutButton") {
    DSErrorView(errorModel: .badRequest("Some description about the error", nil))
        .frame(width: .infinity, height: .infinity)
}
