//
//  DSScreenView.swift
//
//
//  Created by george.apostolakis on 08/02/25.
//

import Core
import SwiftUI

public struct DSScreenView<Content: View>: View {
    @Binding private var state: ScreenState
    private let content: () -> Content
    private let loadingView: () -> AnyView

    public init(
        state: Binding<ScreenState>,
        content: @escaping () -> Content,
        loadingView: @escaping () -> AnyView =  { ProgressView().eraseToAnyView() }
    ) {
        _state = state
        self.content = content
        self.loadingView = loadingView
    }

    public var body: some View {
        switch state {
        case .content: content()

        case .loading:
            loadingView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.dsColor(.reverseColor))

        case .error(let model): DSErrorView(errorModel: model)
        }
    }
}

// MARK: - State
public enum ScreenState {
    case content
    case loading
    case error(DSErrorView.Model)
}

// MARK: - Preview
#Preview("ErrorView") {
    DSScreenView(
        state: .constant(.error(.badRequest("Some description to an error", {}))),
        content: { EmptyView() }
    )
}

#Preview("LoadingView") {
    DSScreenView(
        state: .constant(.loading),
        content: { EmptyView() }
    )
}

#Preview("Content") {
    DSScreenView(
        state: .constant(.content),
        content: { Color.dsColor(.darkContrast).ignoresSafeArea() }
    )
}
