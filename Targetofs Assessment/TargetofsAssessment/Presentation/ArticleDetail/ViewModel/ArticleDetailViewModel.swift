//
//  ArticleDetailViewModel.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 19/04/2024.
//

import UIKit

class ArticleDetailViewModel {
    var articleData: Article?
    private var dataRepository: DataRepositoryProtocol

    init(articleData: Article?, dataRepository: DataRepositoryProtocol) {
        self.dataRepository = dataRepository
        self.articleData = articleData
    }

    func loadImage(completion: @escaping (UIImage?) -> ()) {
        var imageUrl = ""
        if let image = articleData?.media?.first?.mediaMetaData?.last?.url {
            imageUrl = image
        } else {
            imageUrl = articleData?.url ?? ""
        }
        
        dataRepository.fetchImage(id: articleData?.id?.description ?? "", url: imageUrl) { result in
            switch result {
            case .success(let data):
                guard let data else { return }
                DispatchQueue.main.async(execute: { () -> Void in
                    completion(UIImage(data: data))
                })
            case .failure(_):
                completion(nil)
            }
        }
    }
}
