//
//  GitHubPullRequestsView.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 10/02/25.
//

import Components
import SwiftUI

struct GitHubPullRequestsView: View {
    private let repository: GitHubRepositoryResponse
    @StateObject private var viewModel = PullRequestsViewModel()
    @State private var isSheetPresented = false
    @State private var contentMode = ContentMode.all

    init(repository: GitHubRepositoryResponse) {
        self.repository = repository
    }

    var body: some View {
        DSScreenView(state: $viewModel.viewState) {
            buildContentView()
                .background(Color.dsColor(.reverseColor))
        }
        .onAppear {
            viewModel.repository = repository
            Task {
                await viewModel.fetchPullRequests()
            }
        }
        .toolbar {
            ToolbarItem {
                HStack {
                    Image
                        .pullRequestIcon
                        .resizable()
                        .frame(width: 25, height: 25)
                    DSText(AppStrings.PullRequests.title(repository.name ?? ""))
                }
            }
        }
    }

    private func buildContentView() -> some View {
        VStack {
            buildHeader()
            buildListView()
        }
        .padding()
        .sheet(isPresented: $isSheetPresented) {
            buildSheetView()
        }
    }

    private func buildHeader() -> some View {
        HStack {
            buildButton(.all)
            buildButton(.open)
            buildButton(.closed)
            Spacer()
        }
    }

    private func buildButton(_ mode: ContentMode) -> some View {
        DSButton(
            title: AppStrings.PullRequests.pullRequestButtonTitle(
                viewModel.returnListItems(mode).count,
                mode: mode
            ),
            size: .small,
            isDisable: .constant(contentMode == mode)
        ) {
            contentMode = mode
        }
        .fixedSize()
    }

    private func buildListView() -> some View {
        DSInfinityScrollView(
            items: viewModel.returnListItems(contentMode),
            isLoading: viewModel.scrollViewIsLoading
        ) { pullRequest in
            buildListItem(pullRequest)
        } emptyView: {
            VStack(spacing: 25) {
                Image
                    .pullRequestIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                DSText(AppStrings.PullRequests.EmptyView.emptyViewTitle(contentMode), variant: .header)
            }.eraseToAnyView()
        } shouldFetchMoreEntries: { index in
            await viewModel.requestMoreItemsIfNeeded(index, mode: contentMode)
        }
    }

    private func buildListItem(_ pullRequest: GitHubPullRequestResponse) -> some View {
        VStack(spacing: 10) {
            buildListLogo(pullRequest)
            buildListInfo(pullRequest)
            buildListBody(pullRequest)
        }
        .padding()
        .border(Color.dsColor(.primary))    }

    private func buildListLogo(_ pullRequest: GitHubPullRequestResponse) -> some View {
        HStack {
            VStack {
                DSAsyncImage(urlString: pullRequest.user?.avatarUrl ?? "")
                DSText(pullRequest.user?.login ?? "-", variant: .small, textColor: .lightContrast)
            }
            .padding(5)
            .padding(.horizontal)
            VStack {
                DSText(
                    AppStrings.PullRequests.InfoRow.status(pullRequest.state ?? .closed),
                    variant: .body,
                    textColor: .reverseColor
                )
                .padding(5)
                .background(Color.dsColor(pullRequest.state == .open ? .lightContrast : .darkContrast))
                DSButton(
                    title: AppStrings.PullRequests.InfoRow.goToRepository,
                    variant: .text,
                    size: .subtitle
                ) {
                    viewModel.sheetUrl = pullRequest.htmlUrl
                    isSheetPresented = true
                }
                .padding(2)
            }
        }
    }

    private func buildListInfo(_ pullRequest: GitHubPullRequestResponse) -> some View {
        HStack {
            DSText(
                AppStrings.PullRequests.InfoRow.createdAt(
                    pullRequest.createdAt?.formatted(date: .numeric, time: .omitted) ?? "-"
                ),
                variant: .small,
                textColor: .contrast
            )
            .fixedSize(horizontal: true, vertical: false)
            DSText(
                AppStrings.PullRequests.InfoRow.mergedAt(
                    pullRequest.mergedAt?.formatted(date: .numeric, time: .omitted) ?? "-"
                ),
                variant: .small,
                textColor: .contrast
            )
            .fixedSize(horizontal: true, vertical: false)
        }
        .frame(maxWidth: .infinity)
        .border(Color.dsColor(.lightContrast))
        .padding(.horizontal, 5)
    }

    private func buildListBody(_ pullRequest: GitHubPullRequestResponse) -> some View {
        VStack {
            HStack {
                DSText(pullRequest.title ?? "-", variant: .title, textColor: .darkContrast)
                Spacer()
            }
            HStack {
                DSText(pullRequest.body ?? "-", variant: .body)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }
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

// MARK: - Model
enum ContentMode {
    case open
    case closed
    case all
}
