//
//  GitHubAppApp.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//

import SwiftUI

@main
struct GitHubAppApp: App {
    @StateObject private var router = AppRouter()
    
    init() {
        setupNavigationBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
//            GitHubUserListView()
//                .environmentObject(router)
        }
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: Theme.background) ?? UIColor.systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label] // or custom color
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
