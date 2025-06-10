//
//  GitHubAppUITestsLaunchTests.swift
//  GitHubAppUITests
//
//  Created by Arjun Gautami on 23/05/25.
//

import XCTest

final class GitHubAppUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testUserListLoadsAndDisplays() throws {
        
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars["Users"].exists, "User list navigation bar should appear.")

        // Wait for search bar to appear
        let searchBar = app.searchFields["Search users"] // Add accessibilityIdentifier("Search users") in SearchBar TextField
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5))

        // Check if at least one user card exists
        let firstUserCard = app.buttons.matching(identifier: "GitHubUserCard").firstMatch
        XCTAssertTrue(firstUserCard.exists)
    }

    
    func testSearchFiltersUserList() throws {
        let searchField = XCUIApplication().scrollViews.otherElements/*@START_MENU_TOKEN@*/.textFields["GitHubUserCard"]/*[[".textFields[\"Search users\"]",".textFields[\"GitHubUserCard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        
        searchField.tap()
        searchField.typeText("mojo")
        
        // Optionally, wait a little for UI update or use expectation
        sleep(1)
    }
}
