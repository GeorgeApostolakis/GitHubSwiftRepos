//
//  File.swift
//  
//
//  Created by george.apostolakis on 07/02/25.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        Text("HelloWorld")
    }
}

extension ErrorView {
    enum ErrorState {
        case generic(Image, String)
        case badRequest(String)
        case connection

        var image: Image {
            switch self {
            case let .generic(image, _): return image
            case .badRequest: return Image.badRequest
            case .connection: return Image.noConnection
            }
        }

        var title: String {
            switch self {
            case let .generic(_, string): return string
            case let .badRequest(string): return string
            case .connection: return ""
            }
        }
    }
}

#Preview {
    ErrorView()
}
