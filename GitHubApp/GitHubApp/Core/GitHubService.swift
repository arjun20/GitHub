//
//  GitHubService.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//
import SwiftUI

/// A service class responsible for interacting with the GitHub REST API.
///
/// `GitHubService` handles authenticated network requests to fetch users,
/// user details, and repositories from GitHub using a personal access token.
final class GitHubService {
    
    /// The personal access token used for authenticating API requests.
    private let token = "ADD_YOUR_TOKEN"
    
    /// Performs a generic HTTP request and decodes the JSON response into a specified type.
    ///
    /// - Parameter endpoint: The GitHub API endpoint (relative path) to request.
    /// - Returns: A decoded model of type `T` conforming to `Decodable`.
    /// - Throws: `URLError.badURL` if the endpoint is invalid, or any decoding/network error.
    private func request<T:Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: "\(BaseURL.url)\(endpoint)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("\(ConstantName.token) \(token)", forHTTPHeaderField: ConstantName.authorization)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print(prettyPrint(data: data))
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    /// Fetches a list of GitHub users.
    ///
    /// - Returns: An array of `GitHubUser` objects.
    /// - Throws: An error if the network request or decoding fails.
    func fetchUsersData() async throws -> [GitHubUser] {
        try await request(endpoint: EndPoint.users)
    }
    
    /// Fetches detailed information for a specific GitHub user.
    ///
    /// - Parameter userName: The username of the GitHub user.
    /// - Returns: A `GitHubUserDetail` object containing the user’s detailed profile.
    /// - Throws: An error if the network request or decoding fails.
    func fetchUseDetails(userName: String) async throws -> GitHubUserDetail {
        try await request(endpoint: "\(EndPoint.users)/\(userName)")
    }
    
    /// Fetches repositories of a specific GitHub user, excluding forks.
    ///
    /// - Parameter userName: The username of the GitHub user.
    /// - Returns: An array of `GitHubRepository` objects that are not forks.
    /// - Throws: An error if the network request or decoding fails.
    func fetchUserRepos(userName: String) async throws -> [GitHubRepository] {
        let repos: [GitHubRepository] = try await request(endpoint: "\(EndPoint.users)/\(userName)/repos?per_page=100")
        return repos.filter { !$0.fork }
    }
    
    /// Attempts to pretty-print the raw JSON response data.
    ///
    /// - Parameter data: The raw response `Data` from the API.
    /// - Returns: A pretty-printed JSON string if successful, or a fallback error message.
    func prettyPrint(data: Data?) -> String {
        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return "JSON: \(String(decoding: jsonData, as: UTF8.self))"
        } else {
            return ErrorMessage.jsonFaild
        }
    }
}
