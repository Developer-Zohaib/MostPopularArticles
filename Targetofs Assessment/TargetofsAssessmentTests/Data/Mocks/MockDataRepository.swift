//
//  MockDataRepository.swift
//  TargetofsAssessmentTests
//
//  Created by Zohaib Afzal on 24/04/2024.
//

import Foundation
@testable import TargetofsAssessment

class MockDataRepository {
    
    var shouldReturnError = false
    var isFetchArticleCalled = false
    var fetchedPhotos = [Article]()
    var completeClosure: ((Result<[Article], Error>) -> ())!
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError:Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func fetchSuccess() {
        completeClosure(.success(fetchedPhotos))
    }
    
    func fetchFail(error: Error) {
        completeClosure(.failure(error))
    }
    
    func reset(){
        shouldReturnError = false
        isFetchArticleCalled = false
    }
}

extension MockDataRepository: DataRepositoryProtocol {

    func saveImage(id: String, url: String) {}

    func fetchImage(id: String, url: String, complete completion: @escaping (Result<Data?, TargetofsAssessment.APIError>) -> Void) {}

    func fetchArticles(complete completion: @escaping (Result<[Article], Error>) -> Void) {
        let data = MockDataGenerator().mockArticlesData()
        let result: Result<[Article], Error> = .success(data ?? [])
        completion(result)
    }

    func saveArticles(articles: [Article]) {}

}
