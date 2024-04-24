//
//  ArticleListViewModel.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 19/04/2024.
//

import UIKit

protocol ArticleListViewModelDelegate: NSObject {
    func didRecieveError(error: Error)
    func didRecieveData()
}

enum ArticleFilterType {
    case all
    case recent
}

final class ArticleListViewModel {
    
    private var dataRepository: DataRepositoryProtocol
    
    var articleData = ArticleResponse(results: nil)
    var type: ArticleFilterType = .all

    weak var delegate: ArticleListViewModelDelegate?

    init(dataRepository: DataRepositoryProtocol, delegate: ArticleListViewModelDelegate?) {
        self.dataRepository = dataRepository
        self.delegate = delegate
    }

    func fetchArticles() {
        dataRepository.fetchArticles { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                articleData.results = sortArticles(articles: articles)
                delegate?.didRecieveData()
            case .failure(let error):
                delegate?.didRecieveError(error: error)
            }
        }
    }
    
    func loadImage(for indexPath: IndexPath, completion: @escaping (UIImage?) -> ()) {
        let article = getData()?[indexPath.row]
        var imageUrl = ""
        if let image = article?.media?.first?.mediaMetaData?.last?.url {
            imageUrl = image
        } else {
            imageUrl = article?.url ?? ""
        }

        dataRepository.fetchImage(id: article?.id?.description ?? "", url: imageUrl) { result in
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

    func getData() -> [Article]? {
        return  (type == .recent ? filterArticlesByRecent() : articleData.results)
    }
    
    private func sortArticles(articles: [Article]) -> [Article] {
        let sortedArticles = articles.sorted { (article1, article2) -> Bool in
            guard let date1 = article1.updatedDate?.toDate(),
                  let date2 = article2.updatedDate?.toDate() else {
                return false
            }
            return date1 > date2
        }
        return sortedArticles
    }
    
    private func filterArticlesByRecent() -> [Article] {
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date() // Calculate the date 7 days ago
        let articles = articleData.results?.filter { article in
            guard let dateString = article.updatedDate,
                  let date = dateString.toDate() else {
                return false // Skip articles with invalid date strings
            }
            
            // Check if the article's date is on or after 7 days ago
            return date >= sevenDaysAgo
        }
        
        return sortArticles(articles: articles ?? [])
    }
}
