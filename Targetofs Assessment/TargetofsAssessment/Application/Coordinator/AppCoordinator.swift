//
//  AppCoordinator.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 19/04/2024.
//

import UIKit

protocol AppCoordinatorProtocol{
    func showHomeFlow()
}

class AppCoordinator : AppCoordinatorProtocol, CoordinatorFinishDelegate {
    
    func addressSelected(address: String) {
        
    }
    
    //MARK: - Variables
    private weak var finishDelegate: CoordinatorFinishDelegate? = nil
    private var childCoordinators = [any Coordinator]()
    private var type: CoordinatorType {.home}
    let appDIContainer = AppDIContainer()

    //MARK: Helper Methods
    func startFlow(){
        showHomeFlow()
    }
    
    //MARK: - Protocols Methods

    func showHomeFlow() {
        let homeCoordinator = HomeCoordinator(appDIContainer: appDIContainer)
        homeCoordinator.finishDelegate = self
        homeCoordinator.start(from: .articleList)
    }
    
    //MARK: - Coordinator Finish Delegate
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
 
    }
}
