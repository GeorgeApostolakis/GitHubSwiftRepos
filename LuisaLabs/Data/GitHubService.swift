//
//  GitHubService.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 02/02/25.
//

import Foundation

struct GitHubService {
    var fetchRepositories: (GitHubRequest) async throws -> GitHubResponse
}

extension GitHubService {
    static func live() -> GitHubService {
        .init(
            fetchRepositories: {
                let url = try GitHubEndpoints.fetchRepositories($0)

                let (data, _) = try await URLSession.shared.data(from: url)

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(GitHubResponse.self, from: data)
                return response
            }
        )
    }
}

