//
//  webView.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//
import SwiftUI
import WebKit

/// A SwiftUI wrapper for displaying a web page using `WKWebView`.
///
/// Loads the provided URL and enables scrolling.
///
struct WebView: UIViewRepresentable {
    
    /// The URL to load in the web view.
    let url: URL

    /// Creates and configures the `WKWebView`.
    /// - Parameter context: The context provided by SwiftUI.
    /// - Returns: A configured `WKWebView` instance.
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = true
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        
    }
}


/// A container view that presents a web page inside a navigation stack,
/// with a close button to pop the view from the navigation stack.
///
/// - Parameters:
///   - url: The URL to load in the web view.
///   - router: The navigation router used to manage view navigation.
struct WebViewContainer: View {
    let url: URL
    let router: AppRouter
    
    var body: some View {
        NavigationStack {
            WebView(url: url)
                .navigationTitle(ConstantName.repository)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(ConstantName.close) {
                            router.pop()
                        }
                    }
                }
        }
    }
}
