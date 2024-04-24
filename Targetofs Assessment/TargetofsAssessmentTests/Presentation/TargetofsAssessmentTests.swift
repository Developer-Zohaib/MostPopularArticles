//
//  TargetofsAssessmentTests.swift
//  TargetofsAssessmentTests
//
//  Created by Zohaib Afzal on 18/04/2024.
//

import XCTest
@testable import TargetofsAssessment

class TargetofsAssessmentTests: XCTestCase, ArticleListViewModelDelegate {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testWhenFetchBreedsRecieveBreeds_thenViewModelBreedsCountIsEqualToNinetySix_succeeds() {
        // given

        let repositoryMock = MockDataRepository()
        let viewModel = ArticleListViewModel(dataRepository: repositoryMock, delegate: self)

        // when
        viewModel.fetchArticles()

        // then
        XCTAssertEqual((viewModel.articleData.results?.count ?? 0), 2)
    }
    
    // MARK: - ArticleListViewModelDelegate
    
    func didRecieveError(error: Error) {
    }

    func didRecieveData() {
    }
}
