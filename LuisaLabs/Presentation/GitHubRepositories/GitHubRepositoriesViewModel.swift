//
//  ContentView.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 01/02/25.
//

import SwiftUI


// MARK: - ViewModel
class ViewModel: ObservableObject {
    @Published var viewState: GitHubRepositoriesView.ScreenState = .loading
    @Published var total = 0
    @Published var showContents = 0
    @Published var backValueDisable = true
    @Published var forwardValueDisable = false
    @Published var repos: [GitHubRepositoryResponse] = []

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

    private func buildRequest() -> GitHubRequest {
        .init(
            query: query,
            sort: sortBy,
            language: language,
            page: currentPage,
            resultsPerPage: resultPerPage
        )
    }

    func fetchRepositories() async {
        print("fetch")
        viewState = .loading
        do {
            let response = try await service.fetchRepositories(buildRequest())
            print("fetch: \(response)")
            let currentItemCount = itemsInPreviousPages + (response.items?.count ?? 0)
            viewState = .content
            total = response.totalCount ?? 0
            showContents = currentItemCount
            backValueDisable = currentPage == 1
            forwardValueDisable = response.totalCount ?? 0 < currentItemCount
            repos = response.items ?? []
        } catch {
            viewState = .error(error.localizedDescription)
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

// MARK: - Models
