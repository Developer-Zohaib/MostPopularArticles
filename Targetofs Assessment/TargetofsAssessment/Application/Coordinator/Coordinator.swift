//
//  Coordinator.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 19/04/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    associatedtype Destination
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var childCoordinators: [any Coordinator] { get set }
    func finish()
    var type: CoordinatorType { get }
    @discardableResult func start(from destination: Destination) -> UIViewController?
    func set(to destination: Destination)
    func push(to destination: Destination)
    func pop()
    func present(to destination: Destination)
    func dismiss(animated: Bool, completion: @escaping () -> Void)
    func makeViewController(for destination: Destination) -> UIViewController
}

extension Coordinator{
    func finish(){
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
        
    }
    func present(controller viewController: UIViewController){}
    func dismiss(animated: Bool, completion: @escaping () -> Void){}
    func pop(){}
    func present(to destination: HomeDestination, presentationStyle: UIModalPresentationStyle){}
     
}

// MARK: - Coordinator Output
protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: any Coordinator)
    
}

enum CoordinatorType {
    case home
}
