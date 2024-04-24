//
//  MockDataGenerator.swift
//  TargetofsAssessmentTests
//
//  Created by Zohaib Afzal on 19/04/2024.
//

import Foundation
@testable import TargetofsAssessment

class MockDataGenerator {
    func mockArticlesData() -> [Article]? {
        let path = Bundle.main.path(forResource: "articles", ofType: "json")!
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let articles = try decoder.decode(ArticleResponse.self, from: data!)
            return articles.results
        } catch let err {
            print(err)
        }
       return []
    }
}
