//
//  GitHubRepository.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//

import SwiftUI

/// A model representing a GitHub repository.
///
/// Conforms to `Decodable` to decode from API JSON responses and `Identifiable` for SwiftUI use.
struct GitHubRepository: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let stargazers_count: Int
    let html_url: String
    let fork: Bool
}
