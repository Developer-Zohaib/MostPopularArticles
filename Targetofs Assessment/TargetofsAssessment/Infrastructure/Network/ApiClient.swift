//
//  ApiClient.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 24/04/2024.
//

import Foundation
import UIKit

class APIClient: APIClientProtocol {
    
    func fetchInfo<T: Decodable>(_ type: ArticlesRecord, decode: @escaping (Decodable) -> T?, complete completion: @escaping (Result<T, APIError>) -> Void) {

        URLSession.shared.dataTask(with: type.request) { data, response, error in
            
            if let _ = error {
                completion(.failure(.clientError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.serverError))
                return
            }
            print(response)
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do{
                let value = try decoder.decode(T.self, from: data)
                if let result = decode(value){
                    completion(.success(result))
                }
            }catch{
                completion(.failure(.dataDecodingError))
            }
            
        }.resume()
    }
}
