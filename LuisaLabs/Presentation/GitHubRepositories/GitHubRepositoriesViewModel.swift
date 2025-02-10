//
//  ContentView.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 01/02/25.
//

import Components
import SwiftUI


// MARK: - ViewModel
class ViewModel: ObservableObject {
    // MARK: - Properties & init
    @Published var viewState: ScreenState = .loading
    @Published var repos: [GitHubRepositoryResponse] = []
    @Published var scrollViewIsLoading: Bool = false

    var sheetUrl: String?
    var total: Int = 0
    var showContents: Int = 0

    private var currentPage: Int = 1

    private var query: GitHubRequest.GitHubQuery = .init()
    private let service: GitHubService

    init(service: GitHubService = .live()) {
        self.service = service
    }

    // MARK: - Internal Methods
    private func buildRequest() -> GitHubRequest {
        .init(
            query: query,
            page: currentPage
        )
    }

    @MainActor
    private func publishesResult(response: GitHubResponse, isNextPage: Bool) async {
        guard let items = response.items, !items.isEmpty else {
            viewState = .error(
                .badRequest(
                    response.message ?? AppStrings.Repository.Error.noReposFoundError,
                    { [weak self] in
                        guard let self else { return }
                        Task {
                            await self.fetchRepositories()
                        }
                    }
                )
            )
            return
        }
        if isNextPage {
            scrollViewIsLoading = false
        } else {
            viewState = .content
        }
        total = response.totalCount ?? 0
        repos.append(contentsOf: items)
        showContents = repos.count
    }

    // MARK: - Methods
    func fetchRepositories(isNextPage: Bool = false) async {
        await MainActor.run {
            if isNextPage {
                scrollViewIsLoading = true
            } else {
                viewState = .loading
            }
        }
        do {
            let response = try await service.fetchRepositories(buildRequest())
            await publishesResult(response: response, isNextPage: isNextPage)

        } catch {
            await MainActor.run {
                viewState = .error(
                    .badRequest(
                        error.localizedDescription,
                        { [weak self] in
                            guard let self else { return }
                            Task {
                                await self.fetchRepositories()
                            }
                        }
                    )
                )
            }
        }
    }

    @MainActor
    func requestMoreItemsIfNeeded(_ index: Int) async {
        guard shouldRequestMoreItems(index) else { return }
        scrollViewIsLoading = true
        currentPage += 1
        await fetchRepositories(isNextPage: true)
    }

    private func shouldRequestMoreItems(_ index: Int) -> Bool {
        let theFirstRequestIsAlreadyDisplayed = showContents > 0
        let hasReachedNearTheEndOfTheScroll = index == (showContents - 6)
        let hasMoreItems = showContents < total
        return theFirstRequestIsAlreadyDisplayed && hasReachedNearTheEndOfTheScroll && hasMoreItems
    }
}
