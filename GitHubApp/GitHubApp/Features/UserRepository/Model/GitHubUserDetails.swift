//
//  GitHubUserDetails.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//
import Foundation

/// A detailed model representing a GitHub user’s profile information.
///
/// Conforms to `Decodable` for JSON decoding and `Identifiable` for use in SwiftUI.
struct GitHubUserDetail: Decodable, Identifiable {
    let id: Int
    let login: String
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let bio: String?
    let twitter_username: String?
    let public_repos: Int
    let public_gists: Int
    let followers: Int
    let following: Int
    let created_at: String
    let updated_at: String
    let avatar_url: String
    let html_url: String
}
