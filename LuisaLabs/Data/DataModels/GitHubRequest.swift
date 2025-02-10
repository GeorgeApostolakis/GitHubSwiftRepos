//
//  GitHubRequest.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 02/02/25.
//

import Foundation

struct GitHubRequest {
    let query: GitHubQuery
    let sort: SortParameters
    let language: CodeLanguage
    let page: Int
    let resultsPerPage: Int
    let token = "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"

    var requestParameters: [URLQueryItem] {
        let requestParameters: [URLQueryItem] = [
            URLQueryItem(name: "q", value: query.queryString),
            URLQueryItem(name: "sort", value: sort.rawValue),
            URLQueryItem(name: "page", value: page.description),
            URLQueryItem(name: "per_page", value: resultsPerPage.description)
        ]
        return requestParameters
    }
}

// MARK: - SortParameters
extension GitHubRequest {
    enum SortParameters: String {
        case stars = "Stars"
    }
}

// MARK: - CodeLanguage
extension GitHubRequest {
    enum CodeLanguage: String {
        case swift = "Swift"
    }
}

// MARK: - GitHubQuery
extension GitHubRequest {
    struct GitHubQuery {
        private let topics: Topics?
        
        init(topics: Topics? = nil) {
            self.topics = topics
        }
        var queryString: String {
            var string = "language:Swift"
            if let topics {
                string.append("+topics:\(topics.queryString)")
            }
            return string
        }
    }
}

extension GitHubRequest.GitHubQuery {
    struct Topics {
        enum Qualifier {
            case moreThenOf
            case lessThenOf
            case equalTo
        }

        private let qualifier: Qualifier
        private let value: Int

        init(qualifier: Qualifier, value: Int) {
            self.qualifier = qualifier
            self.value = value
        }

        var queryString: String {
            switch qualifier {
            case .moreThenOf: return ">\(value.description)"
            case .lessThenOf: return "<\(value.description)"
            case .equalTo: return value.description
            }
        }
    }
}
