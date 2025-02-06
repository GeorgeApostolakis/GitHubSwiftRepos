//
//  RepositoryWebView.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 06/02/25.
//

import Foundation
import SwiftUI
import UIKit
import WebKit

struct RepositoryWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.bounces = false
        return webView
    }

    func updateUIView(_ wkWebView: WKWebView, context: Context) {
        print("URL: \(url.absoluteString)")
        wkWebView.load(URLRequest(url: url))
    }
}
