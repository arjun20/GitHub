//
//  GitHubUserDetailViewModelTests.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 24/05/25.
//
import XCTest
@testable import GitHubApp

final class GitHubUserDetailViewModelTests: XCTestCase {

    var viewModel: GitHubUserDetailViewModel!

    override func setUp() {
        super.setUp()
        viewModel = GitHubUserDetailViewModel()
    }

    func testSortingRepositoriesHighToLow() {
        viewModel.repositories = [
            GitHubRepository(id: 1, name: "A", description: nil, language: nil, stargazers_count: 10, html_url: "", fork: false),
            GitHubRepository(id: 2, name: "B", description: nil, language: nil, stargazers_count: 30, html_url: "", fork: false),
            GitHubRepository(id: 3, name: "C", description: nil, language: nil, stargazers_count: 20, html_url: "", fork: false)
        ]

        viewModel.sortType = .highToLow
        let sorted = viewModel.sortedRepositories

        XCTAssertEqual(sorted.map { $0.name }, ["A", "C", "B"]) // because sort uses < in highToLow
    }

    func testSortingRepositoriesLowToHigh() {
        viewModel.repositories = [
            GitHubRepository(id: 1, name: "A", description: nil, language: nil, stargazers_count: 10, html_url: "", fork: false),
            GitHubRepository(id: 2, name: "B", description: nil, language: nil, stargazers_count: 30, html_url: "", fork: false),
            GitHubRepository(id: 3, name: "C", description: nil, language: nil, stargazers_count: 20, html_url: "", fork: false)
        ]

        viewModel.sortType = .lowToHigh
        let sorted = viewModel.sortedRepositories

        XCTAssertEqual(sorted.map { $0.name }, ["B", "C", "A"])
    }
}

