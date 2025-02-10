//
//  File.swift
//  
//
//  Created by george.apostolakis on 10/02/25.
//

import Core
import SwiftUI

public struct DSInfinityScrollView<T: Decodable, Content: View>: View {
    private var items: [T]
    private var isLoading: Bool
    private var content: (T) -> Content
    private let emptyView: () -> AnyView
    private let shouldFetchMoreEntries: (Int) async -> Void


    public init(
        items: [T],
        isLoading: Bool,
        content: @escaping (T) -> Content,
        emptyView: @escaping () -> AnyView = { EmptyView().eraseToAnyView() },
        shouldFetchMoreEntries: @escaping (Int) async -> Void
    ) {
        self.items = items
        self.isLoading = isLoading
        self.content = content
        self.emptyView = emptyView
        self.shouldFetchMoreEntries = shouldFetchMoreEntries
    }

    public var body: some View {
        if items.isEmpty {
            emptyView()
        } else {
            scrollView
        }
    }

    private var scrollView: some View {
        ScrollView {
            LazyVStack {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    content(item)
                        .background(Color.dsColor(.reverseColor))
                        .onAppear {
                            Task {
                                await shouldFetchMoreEntries(index)
                            }
                        }
                }
                if isLoading {
                    ProgressView().padding()
                } else {
                    DSText(DSStrings.InfinityScrollView.allItemsHasBeenShown)
                        .frame(maxWidth: .infinity)
                        .background(Color.dsColor(.reverseColor))
                        .padding(.vertical)
                }
            }
        }
        .background(Color.dsColor(.lightContrast))
    }
}
