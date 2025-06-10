//
//  GitHubUserDetailView.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//
import SwiftUI

/// A view that displays detailed information about a GitHub user,
/// including their profile info and a list of repositories.
///
/// Provides UI for sorting repositories by star count,
/// handles loading states, and shows errors if data fetching fails.
///
/// Navigation title is set to the username.
/// Uses a `GitHubUserDetailViewModel` to manage data.
struct GitHubUserDetailView: View {
    
    /// The GitHub username whose details are being displayed.
    let username: String
    
    /// The view model that loads user details and repositories.
    @State private var viewModel = GitHubUserDetailViewModel()
    
    /// The app router to handle navigation actions such as opening repository URLs.
    @EnvironmentObject private var router: AppRouter

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {

                // User Info Section
                if let user = viewModel.user {
                    GitHubUserInfoView(user: user)
                        .padding(.horizontal)
                } else {
                    ProgressView(ConstantName.loding)
                        .padding()
                }

                // Repository Section
                if !viewModel.repositories.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack {
                            
                            Text(ConstantName.repositories)
                                .font(.title2.bold())
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            Menu {
                                ForEach(SortType.allCases) { type in
                                    Button(action: {
                                        viewModel.sortType = type
                                    }) {
                                        Label(type.rawValue, systemImage: viewModel.sortType == type ? imageName.checkmark : "")
                                    }
                                }
                            } label: {
                                Label(ConstantName.sort, systemImage: imageName.sort)
                                    .background(Color(Theme.background))
                                    .labelStyle(IconOnlyLabelStyle())
                                    .padding(.trailing, 8)
                                    .shadow(color: Color(Theme.shadow), radius: 4, x: 2, y: 2)
                            }

                        }
                        .padding(.horizontal)
                        
                        // Display sorted repositories
                        ForEach(viewModel.sortedRepositories) { repo in
                            GitHubRepositoryCard(repo: repo, router: router)
                                .padding(.vertical, 4)
                        }
                    }

                } else if viewModel.user != nil {
                    // No repositories message
                    Text(ConstantName.nonFrked)
                        .foregroundColor(.secondary)
                        .padding()
                        .cornerRadius(16)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical, 16)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(Theme.background).ignoresSafeArea())
        .navigationTitle(username)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadDetails(for: username)
        }
        .alert(ConstantName.appTitle, isPresented: $viewModel.isError) {
            Button(ConstantName.ok, role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}
