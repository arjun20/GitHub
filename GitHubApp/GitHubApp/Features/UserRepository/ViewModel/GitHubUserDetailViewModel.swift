//
//  GitHubUserDetailViewModel.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//
import SwiftUI

/// ViewModel responsible for fetching and managing detailed GitHub user data
/// and their repositories. Provides sorting and error handling support.
///
/// All UI-related updates are published to allow SwiftUI views to reactively update.
///
/// - Note: All async operations are executed on the main actor to ensure UI safety.

@Observable
class GitHubUserDetailViewModel {
    
    /// The detailed GitHub user information fetched from the service.
    var user: GitHubUserDetail?
    
    /// The list of repositories owned by the user (non-forked).
    var repositories: [GitHubRepository] = []
    
    /// Flag indicating if an error occurred during data fetching.
    var isError = false
    
    /// The error message to display if fetching fails.
    var errorMessage = ""
    
    /// The current sorting type applied to the repositories.
    var sortType: SortType = .highToLow

    /// Service responsible for making network requests to GitHub API.
    private let service = GitHubService()

    /// Loads user details and repositories for a given username asynchronously.
    ///
    /// - Parameter username: The GitHub username to fetch details for.
    /// - Note: Filters out forked repositories automatically.
    func loadDetails(for username: String) async {
        do {
            async let userDetails = service.fetchUseDetails(userName: username)
            async let userRepos = service.fetchUserRepos(userName: username)
            
            self.user = try await userDetails
            let allRepos = try await userRepos
            self.repositories = allRepos.filter { !$0.fork }

        } catch {
            isError = true
            errorMessage = error.localizedDescription
        }
    }
    
    /// Returns the repositories sorted according to the selected `sortType`.
    ///
    /// - Returns: A sorted array of `GitHubRepository`.
    var sortedRepositories: [GitHubRepository] {
        switch sortType {
        case .highToLow:
            return repositories.sorted { $0.stargazers_count < $1.stargazers_count }

        case .lowToHigh:
            return repositories.sorted { $0.stargazers_count > $1.stargazers_count }
        }
    }
}
