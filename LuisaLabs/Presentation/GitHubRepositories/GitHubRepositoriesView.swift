//
//  GitHubRepositoriesView.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 02/02/25.
//

import Components
import Core
import SwiftUI

// MARK: - View
struct GitHubRepositoriesView: View {
    struct ViewState {
        let total: Int
        let showContents: Int
        let backValueDisabled: Bool
        let forwardValueDisabled: Bool
        let itens: [GitHubRepositoryResponse]
    }

    enum ScreenState {
        case content
        case loading
        case error(String)
    }

    @StateObject private var viewModel = ViewModel()
    @State private var isSheetPresented = false

    var body: some View {
        DSScreenView(state: $viewModel.viewState) {
            buildContentView()
                .background(Color.dsColor(.reverseColor))
        }
        .onAppear {
            Task {
                await viewModel.fetchRepositories()
            }
        }
        .navigationTitle(AppStrings.Repository.title)
    }

    // MARK: - ContentView
    @ViewBuilder
    private func buildContentView() -> some View {
        VStack {
            buildHeader()
            buildList()
        }
        .padding()
    }

    private func buildHeader() -> some View {
        HStack {
            DSButton(title: AppStrings.Repository.Header.less, variant: .text, size: .small, isDisable: $viewModel.backValueDisable) {
                Task {
                    await viewModel.navigateBack()
                }
            }.fixedSize()
            DSText(
                AppStrings.Repository.Header.quantity(current: viewModel.showContents, total: viewModel.total),
                variant: .subtitle,
                textColor: .lightContrast
            )
            DSButton(title: AppStrings.Repository.Header.more, variant: .text, size: .small, isDisable: $viewModel.forwardValueDisable) {
                Task {
                    await viewModel.navigateForward()
                }
            }.fixedSize()
            Spacer()
        }
        .background(Color.dsColor(.reverseColor))
    }

    private func buildList() -> some View {
        ScrollView {
            ForEach(viewModel.repos) { repository in
                buildListItem(repository)
                    .background(Color.dsColor(.reverseColor))
            }
        }
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
        .sheet(isPresented: $isSheetPresented) {
            buildSheetView()
        }
    }

    private func buildListItem(_ repository: GitHubRepositoryResponse) -> some View {
        HStack {
            VStack {
                DSAsyncImage(urlString: repository.owner?.avatarUrl ?? "")
            }
            .padding(.horizontal)
            Spacer()
            VStack {
                HStack {
                    DSText(repository.name ?? "-", variant: .title)
                    Spacer()
                }
                HStack {
                    DSText(repository.description ?? "-", variant: .subtitle)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
            }
        }
        .padding(.vertical)
        .border(Color.dsColor(.primary))
        .onTapGesture {
            viewModel.sheetUrl = repository.htmlUrl
            isSheetPresented = true
        }
    }

    private func buildSheetView() -> some View {
        VStack {
            if let url = URL(string: viewModel.sheetUrl ?? "") {
                DSWebView(url: url)
            } else {
                DSErrorView(errorModel: .badRequest("A url: \(viewModel.sheetUrl ?? "") não é uma url válida", nil))
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.automatic)
    }
}

// MARK: - Preview
#Preview {
    GitHubRepositoriesView()
}
