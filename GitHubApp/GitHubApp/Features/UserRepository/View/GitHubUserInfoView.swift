//
//  GitHubUserInfoView.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//
import SwiftUI

/// A view that displays detailed user profile information for a GitHub user.
///
/// Shows the user's avatar image, username, optional full name,
/// and follower/following counts in a visually styled card.
///
/// - Parameters:
///   - user: The detailed GitHub user information to display.
struct GitHubUserInfoView: View {
    
    /// The detailed GitHub user data to present.
    let user: GitHubUserDetail

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: user.avatar_url)) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(
                Color.accentColor.opacity(0.6), lineWidth: 2))

            Text(user.login)
                .font(.title.bold())

            if let name = user.name {
                Text(name)
                    .font(.title3)
                    .foregroundColor(.secondary)
            }

            HStack(spacing: 32) {
                Label("\(user.followers)", systemImage: imageName.followewr)
                Divider()
                Label("\(user.following)", systemImage: imageName.following)
            }
            .font(.title3)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .shadow(color: Color(Theme.shadow), radius: 4, x: 2, y: 2)
    }
}
