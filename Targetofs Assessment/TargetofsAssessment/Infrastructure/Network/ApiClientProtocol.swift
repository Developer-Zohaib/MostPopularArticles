//
//  ApiClientProtocol.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 24/04/2024.
//

import Foundation

enum APIError: String, Error {
    case noData
    case clientError
    case serverError
    case dataDecodingError
    case somethingWentWrong
    case localDatabaseError
}

protocol APIClientProtocol {
    func fetchInfo<T: Decodable>(_ type: ArticlesRecord, decode: @escaping (Decodable) -> T?, complete:@escaping (Result<T,APIError> )->())
}
