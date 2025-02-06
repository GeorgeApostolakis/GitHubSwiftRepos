//
//  ContentView.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 01/02/25.
//

import SwiftUI


// MARK: - ViewModel
class ViewModel: ObservableObject {
    // MARK: - Properties & init
    @Published var viewState: GitHubRepositoriesView.ScreenState = .loading
    @Published var total = 0
    @Published var showContents = 0
    @Published var backValueDisable = true
    @Published var forwardValueDisable = false
    @Published var repos: [GitHubRepositoryResponse] = []
    var sheetUrl: String? = nil

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
            await MainActor.run { viewState = .error(error.localizedDescription) }
        }
    }

    func navigateForward() async {
        currentPage += 1
        viewState = .loading
        await fetchRepositories()
    }

    func navigateBack() async {
        guard currentPage > 1 else { return }
        currentPage -= 1
        viewState = .loading
        await fetchRepositories()
    }
}
