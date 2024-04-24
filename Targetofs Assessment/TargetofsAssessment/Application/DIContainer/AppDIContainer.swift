//
//  AppDiContainer.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 19/04/2024.
//

import Foundation
final class AppDIContainer {
    
    func makeArticleListDIContainer() -> ArticleListDIContainer {
        let dependencies = ArticleListDIContainer.Dependencies()
        return ArticleListDIContainer(dependencies: dependencies)
    }
    
    func makeArticleDetailDIContainer() -> ArticleDetailDIContainer {
        let dependencies = ArticleDetailDIContainer.Dependencies()
        return ArticleDetailDIContainer(dependencies: dependencies)
    }
    
}
