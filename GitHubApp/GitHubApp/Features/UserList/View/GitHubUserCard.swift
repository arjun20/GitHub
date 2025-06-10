//
//  GitHubUserCard.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//
import SwiftUI

/// A SwiftUI view that displays a concise card-style representation of a GitHub user.
///
/// `GitHubUserCard` shows the user's avatar, username, and a navigation indicator.
/// It's intended for use in lists or navigation views to represent a user.
struct GitHubUserCard: View {
    
    /// The GitHub user data to display in the card.
    let user: GitHubUser

    var body: some View {
        
        HStack(spacing: 16) {
            // User profile image
            AsyncImage(url: URL(string: user.avatar_url)) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white.opacity(0.4), lineWidth: 1))

            // Username display
            VStack(alignment: .leading, spacing: 4) {
                Text(user.login)
                    .font(.headline)
                    .foregroundColor(.primary)
            }

            Spacer()

            // Trailing navigation icon (chevron or custom)
            Image(systemName: imageName.next)
                .foregroundColor(.gray)
        }
        .accessibilityIdentifier("GitHubUserCard")
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .shadow(color: Color(Theme.shadow), radius: 4, x: 2, y: 2)

    }
}
