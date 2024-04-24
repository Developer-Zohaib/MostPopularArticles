//
//  ArticlesApi.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 24/04/2024.
//

import Foundation

protocol ArticlesApiProtocol {
    func getArticles(from type: ArticlesRecord, completion: @escaping (Result<ArticleResponse, APIError>) -> Void)
}

class ArticlesApi: ArticlesApiProtocol {
    
    let api = APIClient()
    
    // MARK: - ArticlesApiProtocol
    
    func getArticles(from type: ArticlesRecord, completion: @escaping (Result<ArticleResponse, APIError>) -> Void) {
        api.fetchInfo (type, decode: { json -> ArticleResponse? in
            guard let result = json as? ArticleResponse else { return  nil }
            return result
        }, complete: completion)
    }
}
