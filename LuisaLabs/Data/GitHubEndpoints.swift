//
//  GitHubEndpoints.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 05/02/25.
//

import Foundation

enum GitHubEndpoints {
    // "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1"
    static func fetchRepositories(_ request: GitHubRequest) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/search/repositories"
        components.queryItems = request.requestParameters
        guard let url = components.url else {
            throw RepositoryError.incompleteUrl
        }
        return url
    }

    // "https://api.github.com/repos/creator/repo/pulls?state=all"
    static func pullRequests(creator: String, repo: String, page: Int) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/repos/\(creator)/\(repo)/pulls"
        components.queryItems = [
            URLQueryItem(name: "state", value: "all"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "30")
        ]
        guard let url = components.url else {
            throw RepositoryError.incompleteUrl
        }
        return url
    }
}
