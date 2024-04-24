//
//  ArticleDetailDIContainer.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 19/04/2024.
//

import Foundation

final class ArticleDetailDIContainer {
    
    //MARK: - Variables
    struct Dependencies {}
    private let dependencies: Dependencies
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    ///View Controller
    func makeArticleDetailViewController(coordinator: any Coordinator, article: Article?) -> ArticleDetailViewController {
        let articleDetailViewController = ArticleDetailViewController()
        articleDetailViewController.coordinator = coordinator
        articleDetailViewController.viewModel = makeArticleDetailViewModel( article: article)
        return articleDetailViewController
    }

    ///View Model
    private func makeArticleDetailViewModel(article: Article?) -> ArticleDetailViewModel {
        let apiClient = APIClient()
        let persistanceStore = PersistanceStore()
        let dataRepository = DataRepository(persistanceStore: persistanceStore, apiClient: apiClient)
        let viewModel = ArticleDetailViewModel(articleData: article, dataRepository: dataRepository)
        return viewModel
    }
}
