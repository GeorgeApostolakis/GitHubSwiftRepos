//
//  GitHubService.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 02/02/25.
//

import Foundation

struct GitHubService {
    var fetchRepositories: (GitHubRequest) async throws -> GitHubResponse
    var fetchPullRequests: (String, String, Int) async throws -> [GitHubPullRequestResponse]
}

extension GitHubService {
    static func live() -> GitHubService {
        .init(
            fetchRepositories: {
                let url = try GitHubEndpoints.fetchRepositories($0)

                let (data, _) = try await URLSession.shared.data(from: url)

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(GitHubResponse.self, from: data)
            }, fetchPullRequests: { creator, repo, page in
                let url = try GitHubEndpoints.pullRequests(creator: creator, repo: repo, page: page)

                let (data, _) = try await URLSession.shared.data(from: url)

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601

                return try decoder.decode([GitHubPullRequestResponse].self, from: data)
            }
        )
    }
}
