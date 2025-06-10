//
//  GitHubUserListView.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 23/05/25.
//
import SwiftUI

/// A SwiftUI view that displays a searchable list of GitHub users.
///
/// The view uses a `GitHubUserListViewModel` to fetch and filter users,
/// and integrates with `AppRouter` for navigation.
///
/// Features include:
/// - Search bar for filtering users by username.
/// - Pull-to-refresh to reload the user list.
/// - Navigation to user detail views on user selection.
struct GitHubUserListView: View {
    
    /// The view model that manages fetching and filtering GitHub users.
    @State private var viewModel = GitHubUserListViewModel()
    
    /// The app-wide router used for managing navigation.
    @EnvironmentObject private var router: AppRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                VStack(spacing: 0) {
                    
                    /// Search bar bound to the view model's search text.
                    SearchBar(text: $viewModel.searchText)
                        .padding(.horizontal)
                        .padding(.top)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    
                    /// A lazy vertical stack of user cards.
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.filteredUsers) { user in
                            Button {
                                router.push(.UserDetails(userName: user.login))
                            } label: {
                                GitHubUserCard(user: user)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                }
            }
            .refreshable {
                await viewModel.getUser()
            }
            .background(Color(Theme.background).ignoresSafeArea())
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle(ConstantName.userTitle)
            .apNavigationDestination()
        }
        .task {
            await viewModel.getUser()
        }
        .alert(
            ConstantName.appTitle,
            isPresented: $viewModel.isError) {
                Button(ConstantName.ok, role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage)
            }
    }
}
