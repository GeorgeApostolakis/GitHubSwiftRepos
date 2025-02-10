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

struct GitHubRepositoryResponse: Decodable {
    let name: String?
    let fullName: String?
    let description: String?
    let htmlUrl: String?
    let watchersCount: Int?
    let stargazersCount: Int?
    let stargazersUrl: String?
    let forksCount: Int?
    let forksUrl: String?
    let topics: [String]?
    let owner: RepositoryOwnerResponse?
}

struct RepositoryOwnerResponse: Decodable {
    let login: String?
    let avatarUrl: String?
    let htmlUrl: String?
}

struct GitHubPullRequestResponse: Decodable {
    let htmlUrl: String?
    let title: String?
    let state: State
    let body: String?
    let createdAt: Date?
    let mergedAt: Date?

    enum State: String, Decodable {
        case closed
        case open
    }
}
