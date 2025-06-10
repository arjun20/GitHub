//
//  GitHubUser.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//

import SwiftUI

/// A model representing a basic GitHub user returned from the GitHub API.
///
/// Conforms to `Codable`, `Identifiable`, and `Hashable` for use in SwiftUI lists,
/// decoding from JSON, and efficient comparisons.
struct GitHubUser: Codable, Identifiable, Hashable {
    let id: Int
    let login: String
    let avatar_url: String
    let html_url: String
    
    // Optional fields if needed later
    let type: String?
    let site_admin: Bool?
    let followers_url: String?
    
    /// Maps JSON keys in snake_case to Swift property names if needed.
    enum CodingKeys: String, CodingKey {
        case id, login, type
        case avatar_url
        case html_url
        case site_admin
        case followers_url
    }
}
