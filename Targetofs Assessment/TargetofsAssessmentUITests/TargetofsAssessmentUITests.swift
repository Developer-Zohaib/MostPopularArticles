//
//  TargetofsAssessmentUITests.swift
//  TargetofsAssessmentUITests
//
//  Created by Zohaib Afzal on 18/04/2024.
//

import XCTest
@testable import TargetofsAssessment

class TargetofsAssessmentUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testCellCreationAndNavigation_whenArticlesAreLoaded_whenTapped_thenUserShouldBeNaviagtedToDetailScreen_succeeds() {
        
        let app = XCUIApplication()
        let tableViewsQuery = app.tables
        let articleCell = tableViewsQuery.cells[AccessibilityIdentifier.articleCell].firstMatch
        _ = articleCell.waitForExistence(timeout: 3.0)
        
        XCTAssertNotNil(articleCell.exists)
        
        if articleCell.exists {
            articleCell.tap()
            
            XCTAssertNotNil(app.images[AccessibilityIdentifier.articleDetailImageView].firstMatch)
            XCTAssertNotNil(app.staticTexts[AccessibilityIdentifier.articleDetailTitleLabel].firstMatch)
        }
    }
}
