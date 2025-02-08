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
                    .foregroundStyle(.gray)
                DSText(errorModel.title, variant: .header)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                DSText(errorModel.subtitle, variant: .body)
                    .foregroundStyle(.gray)
            }
            .padding()
            .border(.black, width: 0.5)
            if let retryAction {
                Button { retryAction() } label: {
                    DSText("Tentar Novamente", variant: .title)
                        .padding(.all, 35)
                        .border(.black)
                        .clipShape(.rect(cornerRadius: 12))
                        .frame(maxWidth: .infinity, alignment: .bottom)
                }.fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        .frame(width: 360, height: 800)
}
