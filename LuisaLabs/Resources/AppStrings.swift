//
//  AppStrings.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 09/02/25.
//

import Core

// swiftlint: disable all
enum AppStrings {
    enum Repository {
        static var title = "GitHub Swift"
        enum Header {
            static var less = "Menos"
            static func quantity(current: Int, total: Int) -> String {
                "\(current.formatted()) de \(total.formatted())"
            }
            static var more = "Mais"
        }
        enum Error {
            static var noReposFoundError = "Nenhum repositório foi encontrado com estes parâmetros de pesquisa"
        }
    }
}
// swiftlint: enable all
