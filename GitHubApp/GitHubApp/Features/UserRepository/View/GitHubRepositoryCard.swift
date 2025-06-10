//
//  GitHubRepositoryCard.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//
import SwiftUI

/// A SwiftUI view that displays a summary card for a GitHub repository.
///
/// The card shows the repository's name, optional description, primary language,
/// and star count. Tapping the card navigates to a web view displaying the repository page.
///
/// - Note: Uses `AppRouter` to handle navigation to the repository URL.
struct GitHubRepositoryCard: View {
    
    /// The GitHub repository data to display.
    let repo: GitHubRepository
    
    /// The router responsible for managing app navigation.
    let router: AppRouter

    var body: some View {
        Button {
            if let url = URL(string: repo.html_url) {
                router.push(.webView(url: url))
            }
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(repo.name).font(.headline)

                if let description = repo.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                HStack(spacing: 12) {
                    if let language = repo.language {
                        Label(language, systemImage: imageName.language)
                        Divider()
                    }
                    Label("\(repo.stargazers_count)", systemImage: imageName.star)
                }
                .font(.caption)
                .foregroundColor(.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color(Theme.shadow), radius: 4, x: 2, y: 2)
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}
