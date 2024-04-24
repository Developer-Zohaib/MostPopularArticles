//
//  HomeCoordinator.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 19/04/2024.
//

import UIKit

enum HomeDestination {
 case articleList
 case articleDetail(Article?)
}

protocol HomeCoordinatorProtocol: AnyObject, Coordinator {
    func set(to destination: HomeDestination )
}

class HomeCoordinator: HomeCoordinatorProtocol {
    
    //MARK: - Variabels
    typealias Destination = HomeDestination
    private(set) var navigationController = UINavigationController()
    var appDIContainer: AppDIContainer
    var type: CoordinatorType {.home}
    var childCoordinators: [any Coordinator] = []
    weak var finishDelegate: CoordinatorFinishDelegate?
    let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var window = UIWindow()

    //MARK: - Init
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
        
        if #available(iOS 13.0, *) {
            window = sceneDelegate.window!
        } else {
            window = appDelegate.window!
        }

    }
    
    //MARK: - Coordinator
    @discardableResult func start(from destination: Destination) -> UIViewController? {
        window.rootViewController = navigationController
        push(to: destination)
        return self.navigationController
    }
    
    func set(to destination: Destination) {
        let controller = makeViewController(for: destination)
        navigationController.setViewControllers([controller], animated: false)
    }
    
    func push(to destination: Destination) {
        let controller = makeViewController(for: destination)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func present(to destination: HomeDestination) {
        let controller = makeViewController(for: destination)
        navigationController.present(controller, animated: true)
    }
    
    func dismiss(animated: Bool, completion: @escaping () -> Void) {
        navigationController.dismiss(animated: animated)
    }
    
    func pop(isRoot: Bool = false) {
        if isRoot{
            navigationController.popToRootViewController(animated: true)
        }else{
            navigationController.popViewController(animated: true)
        }
    }
    
    func makeViewController(for destination: HomeDestination) -> UIViewController {
        switch destination {
        case .articleList:
            let diContainer = appDIContainer.makeArticleListDIContainer()
            let articleListViewController = diContainer.makeArticleListViewController(coordinator: self)
            return articleListViewController
            
        case .articleDetail(let article):
            let diContainer = appDIContainer.makeArticleDetailDIContainer()
            let articleDetailViewController = diContainer.makeArticleDetailViewController(coordinator: self, article: article)
            return articleDetailViewController
        }
    }
}
