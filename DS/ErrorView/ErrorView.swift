//
//  ErrorView.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 07/02/25.
//

import SwiftUI

struct ErrorView: View {

    private let errorType: String

    var body: some View {
        VStack {
            Image.errorImage
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            Text("Title")
                .font(.dsFont(type: .largeTitle))
            Text("subTitle")
                .font(.dsFont(type: .body))
        }
    }
}

enum ErrorType {
    case generic(String)
    case connection
    case badRequest(String)
    case internalProblem

    var title: String {
        switch self {
        case .generic(let string): return "Ops, aconteceu um erro aqui!"
        case .connection: return "Ops, parece que estamos sem internet."
        case .badRequest(let string): "Ops, tivemos"
        case .internalProblem:
            <#code#>
        }
    }
}

#Preview {
    ErrorView()
}
