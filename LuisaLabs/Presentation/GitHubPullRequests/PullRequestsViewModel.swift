//
//  PullRequestsViewModel.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 10/02/25.
//

import Core
import Components
import SwiftUI

class PullRequestsViewModel: ObservableObject {
    // MARK: - Properties & init
    @Published var viewState: ScreenState = .loading
    var scrollViewIsLoading: Bool = false
    var repository: GitHubRepositoryResponse?

    var sheetUrl: String?
    @Published var pullRequestResponse = PaginatedResponse<GitHubPullRequestResponse>()
    var hasMoreItems = true

    @Published var openPullRequests = [GitHubPullRequestResponse]()
    @Published var closedPullRequests = [GitHubPullRequestResponse]()

    private var query: GitHubRequest.GitHubQuery = .init()
    private let service: GitHubService

    init(service: GitHubService = .live()) {
        self.service = service
    }

    // MARK: - Methods
    func fetchPullRequests() async {
        guard hasMoreItems else { return }
        await MainActor.run {
            if pullRequestResponse.items.isEmpty {
                viewState = .loading
            } else {
                scrollViewIsLoading = true
            }
        }
        do {
            let response = try await service
                .fetchPullRequests(
                    repository?.owner?.login ?? "",
                    repository?.name ?? "",
                    pullRequestResponse.currentPage
                )
            if response.isEmpty {
                hasMoreItems = false
            }
            await publishesResult(response)
        } catch let error {
            await MainActor.run {
                viewState = .error(
                    .badRequest(
                        error.localizedDescription,
                        { [weak self] in
                            guard let self else { return }
                            Task {
                                await self.fetchPullRequests()
                            }
                        }
                    )
                )
            }
        }
    }

    func returnListItems(_ mode: ContentMode) -> [GitHubPullRequestResponse] {
        switch mode {
        case .open: return openPullRequests
        case .closed: return closedPullRequests
        case .all: return pullRequestResponse.items
        }
    }

    func requestMoreItemsIfNeeded(_ index: Int, mode: ContentMode) async {
        guard shouldRequestMoreItems(index, mode: mode) else { return }
        await MainActor.run {
            pullRequestResponse.currentPage += 1
        }
        await fetchPullRequests()
    }

    private func shouldRequestMoreItems(_ index: Int, mode: ContentMode) -> Bool {
        let items = returnListItems(mode)
        let theFirstRequestIsAlreadyDisplayed = !items.isEmpty
        let hasReachedNearTheEndOfTheScroll = index >= (items.count - 3)
        return theFirstRequestIsAlreadyDisplayed && hasReachedNearTheEndOfTheScroll && hasMoreItems
    }

    @MainActor
    private func publishesResult(_ response: [GitHubPullRequestResponse]) async {
        guard !pullRequestResponse.items.isEmpty || !response.isEmpty else {
            viewState = .error(
                .badRequest(
                    AppStrings.PullRequests.Error.noPRsFoundError,
                    { [weak self] in
                        guard let self else { return }
                        Task {
                            await self.fetchPullRequests()
                        }
                    }
                )
            )
            return
        }
        if pullRequestResponse.items.isEmpty {
            viewState = .content
        } else {
            scrollViewIsLoading = false
        }
        pullRequestResponse.items.append(contentsOf: response)
        openPullRequests = pullRequestResponse.items.filter { $0.state == .open }
        closedPullRequests = pullRequestResponse.items.filter { $0.state == .closed }
    }
}
