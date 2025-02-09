//
//  File.swift
//  
//
//  Created by george.apostolakis on 09/02/25.
//

import SwiftUI
import WebKit

public struct DSWebView: UIViewRepresentable {
    let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.bounces = false
        return webView
    }

    public func updateUIView(_ wkWebView: WKWebView, context: Context) {
        wkWebView.load(URLRequest(url: url))
    }
}
