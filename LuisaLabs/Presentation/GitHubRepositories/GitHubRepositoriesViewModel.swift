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
    var sheetUrl: String?
    var total: Int = 0
    var showContents: Int = 0
    var backValueDisable = true
    var forwardValueDisable = false

    private var currentPage: Int = 1
    private var resultPerPage: Int = 30
    private var itemsInPreviousPages: Int {
        (currentPage - 1) * resultPerPage
    }
    private var language: GitHubRequest.CodeLanguage = .swift
    private var sortBy: GitHubRequest.SortParameters = .stars
    private var query: GitHubRequest.GitHubQuery = .init()
    private let service: GitHubService

    init(service: GitHubService = .live()) {
        self.service = service
    }

    // MARK: - Internal Methods
    private func buildRequest() -> GitHubRequest {
        .init(
            query: query,
            sort: sortBy,
            language: language,
            page: currentPage,
            resultsPerPage: resultPerPage
        )
    }

    @MainActor
    private func publishesResult(response: GitHubResponse) async {
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
        let currentItemCount = itemsInPreviousPages + (response.items?.count ?? 0)
        viewState = .content
        total = response.totalCount ?? 0
        showContents = currentItemCount
        backValueDisable = currentPage == 1
        forwardValueDisable = response.totalCount ?? 0 < currentItemCount
        repos = response.items ?? []
    }

    // MARK: - Methods
    func fetchRepositories() async {
        await MainActor.run { viewState = .loading }
        do {
            let response = try await service.fetchRepositories(buildRequest())
            await publishesResult(response: response)
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
    func navigateForward() async {
        currentPage += 1
        viewState = .loading
        await fetchRepositories()
    }

    @MainActor
    func navigateBack() async {
        guard currentPage > 1 else { return }
        currentPage -= 1
        viewState = .loading
        await fetchRepositories()
    }
}
