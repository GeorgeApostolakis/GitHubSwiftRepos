//
//  RepositoriesViewModel.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 01/02/25.
//

import Components
import Core
import SwiftUI

// MARK: - ViewModel
class RepositoriesViewModel: ObservableObject {
    // MARK: - Properties & init
    @Published var viewState: ScreenState = .loading
    var scrollViewIsLoading: Bool = false

    var sheetUrl: String?

    @Published var repositoryResponse = PaginatedResponse<GitHubRepositoryResponse>()

    private var query: GitHubRequest.GitHubQuery = .init()
    private let service: GitHubService

    init(service: GitHubService = .live()) {
        self.service = service
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
        guard repositoryResponse.shouldRequestMoreItems(index) else { return }
        scrollViewIsLoading = true
        repositoryResponse.currentPage += 1
        await fetchRepositories(isNextPage: true)
    }

    // MARK: - Internal Methods
    private func buildRequest() -> GitHubRequest {
        .init(
            query: query,
            page: repositoryResponse.currentPage
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
        repositoryResponse.total = response.totalCount ?? 0
        repositoryResponse.items.append(contentsOf: items)
        repositoryResponse.showContents = repositoryResponse.items.count
    }
}
