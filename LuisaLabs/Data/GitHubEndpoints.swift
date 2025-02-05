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
}
