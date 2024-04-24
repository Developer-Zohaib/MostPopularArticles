//
//  EndPoint.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 24/04/2024.
//

import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!.absoluteString.removingPercentEncoding!
        let request = URLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalCacheData)
        //request.setValue("api-key \(AppConfiguration().apiAccessKey)", forHTTPHeaderField: "Authorization")
        return request
    }
}

enum ArticlesRecord {
    
    case articleLists
}

extension ArticlesRecord: Endpoint {
    
    var base: String {
        return AppConfiguration().apiBaseURL
    }
    
    var path: String {
        switch self {
        case .articleLists:
            return "/svc/mostpopular/v2/mostviewed/all-sections/30.json?api-key=" + AppConfiguration().apiAccessKey
        }
    }
}
