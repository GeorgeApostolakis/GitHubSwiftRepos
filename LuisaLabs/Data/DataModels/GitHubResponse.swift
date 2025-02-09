//
//  GitHubResponse.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 02/02/25.
//

import Foundation

struct GitHubResponse: Decodable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [GitHubRepositoryResponse]?

    let message: String?
}

struct GitHubRepositoryResponse: Decodable, Identifiable {
    let id = UUID()
    let name: String?
    let description: String?
    let htmlUrl: String?
    let watchersCount: Int?
    let stargazersCount: Int?
    let forkCount: Int?
    let topics: [String]?
    let owner: RepositoryOwnerResponse?

    struct RepositoryOwnerResponse: Decodable {
        let login: String?
        let avatarUrl: String?
    }
}
