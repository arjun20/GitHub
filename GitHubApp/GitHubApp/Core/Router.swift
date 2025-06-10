//
//  Router.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//
import SwiftUI
import Combine

/// Represents navigation destinations within the app.
///
/// Conforms to `Hashable` to support navigation in SwiftUI using `NavigationStack`.
enum AppRoute: Hashable {
    
    /// Navigates to the GitHub user detail screen.
    ///
    /// - Parameter userName: The username of the GitHub user to display.
    case UserDetails(userName: String)
    
    /// Opens a URL in a web view.
    ///
    /// - Parameter url: The URL to be loaded in the web view.
    case webView(url: URL)
}

/// A router that manages the navigation stack for the application using `AppRoute`.
///
/// Use `push(_:)` to add a new route, and `pop()` to remove the most recent route.
class AppRouter: ObservableObject {
    
    /// The current navigation path represented as a stack of `AppRoute` values.
    @Published var path: [AppRoute] = []

    
    /// Pushes a new route onto the navigation stack.
    ///
    /// - Parameter route: The `AppRoute` to be added to the navigation stack.
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    /// Pops the most recent route off the navigation stack.
    func pop() {
        path.removeLast()
    }
}

/// A shared holder for navigation paths, useful for scenarios requiring multiple navigation contexts.
class NavigationPathHolder: ObservableObject {
    
    /// The navigation path represented as an array of `AppRoute` values.
    @Published var path: [AppRoute] = []
}

extension View {
    
    /// Injects an instance of `AppRouter` into the SwiftUI environment.
    ///
    /// This allows any child view to access and interact with the router.
    ///
    /// - Returns: A view with the `AppRouter` environment object applied.
    func withRouter() -> some View {
        self.environmentObject(AppRouter())
    }
}

extension View {
    
    /// Applies navigation destinations for `AppRoute` to the current view.
    ///
    /// This enables deep linking and route-specific destination views in a `NavigationStack`.
    ///
    /// - Returns: A view configured to handle navigation for all `AppRoute` cases.
    func apNavigationDestination() -> some View {
        self.navigationDestination(for: AppRoute.self) { route in
            switch route {
            case .UserDetails(let user):
                GitHubUserDetailView(username: user)

            case .webView(let url):
                WebView(url: url)
            }
        }
    }
}
