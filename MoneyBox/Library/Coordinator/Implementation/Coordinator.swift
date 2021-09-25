//
//  Coordinator.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 19.09.2021.
//

import UIKit

class Coordinator: Coordinatable {
    
    private var childCoordinators = [Coordinatable]()
    
    var toPresent: UIViewController? { nil }
    
    func start() {}
    
    func addDependency(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinatable?) {
        guard childCoordinators.isEmpty == false,
              let coordinator = coordinator else { return }
        
        if let coordinator = coordinator as? Coordinator,
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
