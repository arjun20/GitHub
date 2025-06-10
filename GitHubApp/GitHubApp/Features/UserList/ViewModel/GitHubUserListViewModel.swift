//
//  GitHubUserListViewModel.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//
import SwiftUI

/// The view model responsible for fetching and managing a list of GitHub users.
///
/// This class handles:
/// - Fetching users asynchronously from the GitHub API via `GitHubService`.
/// - Managing search text input for filtering users.
/// - Tracking error states and messages for display in the UI.
///
@Observable
class GitHubUserListViewModel {
    
    /// The complete list of fetched GitHub users.
    var users: [GitHubUser] = []
    
    /// A Boolean flag indicating whether an error has occurred during data fetching.
    var isError: Bool = false
    
    /// The error message to display when `isError` is true.
    var errorMessage: String = ""
    
    /// The current text used to filter the user list by username.
    var searchText: String = ""

    /// The service used to fetch GitHub user data.
    private let service = GitHubService()
    
    
    /// Asynchronously fetches GitHub users and updates the `users` property.
    ///
    /// If an error occurs during fetching, updates `isError` and `errorMessage`.
    func getUser() async {
        do {
            users = try await service.fetchUsersData()
        } catch {
            isError = true
            errorMessage = error.localizedDescription
        }
    }
    
    /// Returns a filtered array of users based on the `searchText`.
    ///
    /// If `searchText` is empty, returns the full `users` array.
    var filteredUsers: [GitHubUser] {
        if searchText.isEmpty { return users }
        return users.filter { $0.login.lowercased().contains(searchText.lowercased()) }
    }
}
