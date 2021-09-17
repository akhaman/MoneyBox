//
//  Coordinator.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 11.09.2021.
//

import Foundation

protocol Coordinator: AnyObject {
    
    func start()
}

class BaseCoordinator: Coordinator {
    
    private var childCoordinators = [Coordinator]()
    
    func start() {}
    
    func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false,
              let coordinator = coordinator else { return }
        
        if let coordinator = coordinator as? BaseCoordinator,
           !coordinator.childCoordinators.isEmpty {
           
            coordinator.childCoordinators
                .filter { $0 !== coordinator }
                .forEach { coordinator.removeDependency($0) }
        }
        
        childCoordinators.enumerated()
            .filter { $0.element === coordinator }
            .forEach { childCoordinators.remove(at: $0.offset) }
    }
}
