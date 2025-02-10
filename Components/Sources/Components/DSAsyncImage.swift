//
//  DSAsyncImage.swift
//
//
//  Created by george.apostolakis on 07/02/25.
//

import Core
import SwiftUI

public struct DSAsyncImage: View {
    let urlString: String
    let errorView: () -> AnyView
    let placeholder: () -> Image
    let size: CGSize

    /// Creates a customizable DSAsyncImage.
    ///
    /// - Parameters:
    ///   - urlString: the url string to get the image to be displayed.
    ///   - size: the size of the image to be displayed.
    ///   - errorView: the `View` that will be displayed when an error is returned.
    ///   - placeHolder: the `Image` that will be displayed before / while the load operation.
    public init(
        urlString: String,
        size: Size = .small,
        errorView: @escaping () -> AnyView = { Image.negativeFeedback.eraseToAnyView() },
        placeholder: @escaping () -> Image = { Image.emptyImage }
    ) {
        self.urlString = urlString
        self.size = size.size
        self.errorView = errorView
        self.placeholder = placeholder
    }

    public var body: some View {
        if let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    placeholder()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.width, height: size.height)

                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.width, height: size.height)

                case .failure(let error): buildErrorView(error.localizedDescription)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)

                @unknown default: buildErrorView("DSAsyncImage failed to unknown phase")
                }
            }
        } else {
            placeholder()
                .frame(width: size.width, height: size.height)
        }
    }

    private func buildErrorView(_ errorString: String) -> AnyView {
        print("DSAsyncImage failed to load image, url: \(urlString), error: \(errorString)")
        return errorView()
    }
}

// MARK: - DSAsyncImage
extension DSAsyncImage {
    public enum Size {
        case small
        case medium
        case large
        case custom(CGSize)

        var size: CGSize {
            switch self {
            case .small: return .init(width: 40, height: 40)
            case .medium: return .init(width: 50, height: 50)
            case .large: return .init(width: 60, height: 60)
            case let .custom(size): return size
            }
        }
    }
}


// MARK: - Preview

struct DSAsyncImage_Previews: PreviewProvider {
    static let urlString = "https://cdn.pixabay.com/photo/2022/01/30/13/33/github-6980894_1280.png"
    static func buildAsyncImage(url: String = urlString, size: DSAsyncImage.Size = .small) -> some View {
        DSAsyncImage(
            urlString: url,
            size: size,
            errorView: {
                Image.negativeFeedback
                    .resizable()
                    .foregroundColor(.red)
                    .eraseToAnyView()
            }, placeholder: {
                Image.emptyImage
            }
        ).fixedSize()
    }


    static var previews: some View {
        VStack {
            buildAsyncImage(size: .small)
            buildAsyncImage(size: .medium)
            buildAsyncImage(size: .large)
            buildAsyncImage(size: .custom(.init(width: 100, height: 100)))
            buildAsyncImage(url: "someBrokenUrl", size: .large)
        }
    }
}
