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

    @StateObject private var viewModel = RepositoriesViewModel()
    @State private var isSheetPresented = false

    var body: some View {
        NavigationStack {
            DSScreenView(state: $viewModel.viewState) {
                buildContentView()
                    .background(Color.dsColor(.reverseColor))
            }
            .onAppear {
                if viewModel.repositoryResponse.showContents == 0 {
                    Task {
                        await viewModel.fetchRepositories()
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    HStack {
                        Image
                            .githubIcon
                            .resizable()
                            .frame(width: 25, height: 25)
                        DSText(AppStrings.Repository.title)
                    }
                }
            }
        }
    }

    // MARK: - ContentView
    @ViewBuilder
    private func buildContentView() -> some View {
        VStack {
            buildHeader()
            buildList()
        }
        .padding()
        .sheet(isPresented: $isSheetPresented) {
            buildSheetView()
        }
    }

    private func buildHeader() -> some View {
        HStack {
            DSText(
                AppStrings.Repository.Header.quantity(
                    current: viewModel.repositoryResponse.showContents,
                    total: viewModel.repositoryResponse.total
                ),
                variant: .subtitle,
                textColor: .lightContrast
            )
        }
        .background(Color.dsColor(.reverseColor))
    }

    private func buildList() -> some View {
        DSInfinityScrollView(
            items: viewModel.repositoryResponse.items,
            isLoading: viewModel.scrollViewIsLoading
        ) { repo in
            buildListItem(repo)
        } emptyView: {
            VStack(spacing: 25) {
                Image
                    .githubIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                DSText(AppStrings.Repository.EmptyState.title, variant: .header)
            }.eraseToAnyView()
        } shouldFetchMoreEntries: { index in
            await viewModel.requestMoreItemsIfNeeded(index)
        }
    }

    private func buildListItem(_ repository: GitHubRepositoryResponse) -> some View {
        HStack {
            buildLogo(repository)
            Spacer()
            buildListBody(repository)
        }
        .padding(.vertical)
        .border(Color.dsColor(.primary))
    }

    private func buildLogo(_ repository: GitHubRepositoryResponse) -> some View {
        Button {
            viewModel.sheetUrl = repository.owner?.htmlUrl
            isSheetPresented = true
        } label: {
            VStack {
                DSAsyncImage(urlString: repository.owner?.avatarUrl ?? "")
                DSText(repository.owner?.login ?? "", variant: .small, textColor: .lightContrast)
            }
            .padding(5)
            .border(Color.dsColor(.contrast))
            .padding(.horizontal)
        }
    }

    private func buildListBody(_ repository: GitHubRepositoryResponse) -> some View {
        VStack {
            HStack {
                DSText(repository.name ?? "-", variant: .title, textColor: .darkContrast)
                Spacer()
            }
            HStack {
                DSText(repository.description ?? "-", variant: .body)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            HStack {
                buildCounter(image: .forkIcon, count: repository.forksCount?.formatted() ?? "-")
                buildCounter(image: .starIcon, count: repository.stargazersCount?.formatted() ?? "-")
                Button {
                    viewModel.sheetUrl = repository.htmlUrl
                    isSheetPresented = true
                } label: {
                    Image
                        .githubIcon
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(2)
                        .border(Color.dsColor(.primary))
                }
                NavigationLink {
                    GitHubPullRequestsView(repository: repository)
                } label: {
                    Image
                        .pullRequestIcon
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(2)
                        .border(Color.dsColor(.primary))
                }
                Spacer()
            }
        }
    }

    private func buildCounter(image: Image, count: String) -> some View {
        HStack(spacing: 4) {
            image.resizable().frame(width: 15, height: 15)
            DSText(count)
        }
        .padding(2)
    }

    private func buildSheetView() -> some View {
        VStack {
            if let url = URL(string: viewModel.sheetUrl ?? "") {
                DSWebView(url: url)
            } else {
                DSErrorView(
                    errorModel: .badRequest(AppStrings.Repository.Error.invalidUrl(viewModel.sheetUrl ?? ""), nil)
                )
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
