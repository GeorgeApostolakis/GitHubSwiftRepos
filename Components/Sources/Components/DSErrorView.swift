//
//  DSErrorView.swift
//  
//
//  Created by george.apostolakis on 07/02/25.
//

import SwiftUI

public struct DSErrorView: View {
    private typealias Action = () -> Void

    private let errorModel: Model
    private let retryAction: Action?

    public init(errorModel: Model, retryAction: (() -> Void)? = nil) {
        self.errorModel = errorModel
        self.retryAction = retryAction
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
            if let retryAction {
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
        case generic(Image, String)
        case badRequest(String)
        case connection

        var image: Image {
            switch self {
            case let .generic(image, _): return image
            case .badRequest: return Image.badRequest
            case .connection: return Image.noConnection
            }
        }

        var title: String {
            switch self {
            case .generic: return DSStrings.ErrorView.genericTitle
            case .badRequest: return DSStrings.ErrorView.badRequestTitle
            case .connection: return DSStrings.ErrorView.connectionTitle
            }
        }

        var subtitle: String {
            switch self {
            case let .generic(_, string): return string
            case let .badRequest(string): return string
            case .connection: return DSStrings.ErrorView.connectionSubTitle
            }
        }
    }
}

#Preview {
    DSErrorView(errorModel: .connection, retryAction: {})
        .frame(width: .infinity, height: .infinity)
}
