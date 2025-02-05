//
//  RepositoryErrors.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 02/02/25.
//

import Foundation

enum RepositoryError: LocalizedError {
    case incompleteUrl
    case noElements
    case requestError(GitHubError)
    case decodeError

    var errorDescription: String? {
        switch self {
        case .incompleteUrl: "Not able to build URL from components"
        case .noElements: "Response returned without repositories"
        case let .requestError(gitError): "GitHub error: \(gitError.message)"
        case .decodeError: ""
        }
    }
}

struct GitHubError: Decodable {
    let message: String
}
