//
//  GitHubUserListViewModelTests.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 24/05/25.
//
import XCTest
@testable import GitHubApp

final class GitHubUserListViewModelTests: XCTestCase {

    var viewModel: GitHubUserListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = GitHubUserListViewModel()
    }

    func testSearchFilterReturnsCorrectResults() {
        viewModel.users = [
            GitHubUser(id: 1, login: "john", avatar_url: "", html_url: "", type: nil, site_admin: nil, followers_url: nil),
            GitHubUser(id: 2, login: "alice", avatar_url: "", html_url: "", type: nil, site_admin: nil, followers_url: nil),
            GitHubUser(id: 3, login: "jack", avatar_url: "", html_url: "", type: nil, site_admin: nil, followers_url: nil)
        ]

        viewModel.searchText = "ja"
        let results = viewModel.filteredUsers

        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.login, "jack")
    }
}

