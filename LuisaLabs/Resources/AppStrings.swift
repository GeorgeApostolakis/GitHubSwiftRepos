//
//  AppStrings.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 09/02/25.
//

import Core
import Foundation

// swiftlint: disable all
enum AppStrings {
    enum Repository {
        static var title = "GitHub Swift | Repositories"
        enum Header {
            static var less = "Menos"
            static func quantity(current: Int, total: Int) -> String {
                "\(current.formatted()) de \(total.formatted())"
            }

            static var more = "Mais"
        }

        enum Error {
            static var noReposFoundError = "Nenhum repositório foi encontrado com estes parâmetros de pesquisa"

            static func invalidUrl(_ urlString: String) -> String {
                "A url: \(urlString) não é uma url válida"
            }
        }

        enum EmptyState {
            static var title = "Nenhum repositório em swift disponível!"
        }
    }

    enum PullRequests {
        static func title(_ repo: String) -> String {
            "\(repo.capitalized) | Pull Requests"
        }

        static func pullRequestButtonTitle(_ count: Int, mode: ContentMode) -> String {
            switch mode {
            case .open: return "Open [\(count.formatted())]"
            case .closed: return "Closed [\(count.formatted())]"
            case .all: return "All [\(count.formatted())]"
            }

        }

        enum Error {
            static var noPRsFoundError = "Nenhum PullRequest foi encontrado com estes parâmetros de pesquisa"
        }

        enum InfoRow {
            static func createdAt(_ date: String) -> String {
                "Criado em: \(date)"
            }

            static func mergedAt(_ date: String) -> String {
                "Mergeado em: \(date)"
            }

            static func status(_ state: GitHubPullRequestResponse.State) -> String {
                switch state {
                case .closed: "Fechado"
                case .open: "Aberto"
                }
            }

            static var goToRepository = "Abrir PR"
        }

        enum EmptyView {
            static func emptyViewTitle(_ mode: ContentMode) -> String {
                switch mode {
                case .open: return "Não foram encontrados pull requests abertos para este repositório"
                case .closed: return "Não foram encontrados pull requests fechados para este repositório"
                case .all: return "Não foram encontrados pull requests para este repositório"
                }
            }
        }
    }
}
// swiftlint: enable all
