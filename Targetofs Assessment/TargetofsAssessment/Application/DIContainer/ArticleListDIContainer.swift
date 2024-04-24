//
//  ArticleListDIContainer.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 19/04/2024.
//

import Foundation

final class ArticleListDIContainer {
    
    //MARK: - Variables
    struct Dependencies {}
    private let dependencies: Dependencies
    
    //MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    ///View Controller
    func makeArticleListViewController(coordinator: any Coordinator) -> ArticleListViewController {
        let articleListViewController = ArticleListViewController()
        articleListViewController.coordinator = coordinator
        articleListViewController.viewModel = makeArticleListViewModel(delegate: articleListViewController)
        return articleListViewController
    }

    ///View Model
    private func makeArticleListViewModel(delegate: ArticleListViewModelDelegate?) -> ArticleListViewModel {
        let apiClient = APIClient()
        let persistanceStore = PersistanceStore()
        let dataRepository = DataRepository(persistanceStore: persistanceStore, apiClient: apiClient)
        return ArticleListViewModel(dataRepository: dataRepository, delegate: delegate)
    }
}
