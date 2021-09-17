//
//  ApplicationCoordinator.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 11.09.2021.
//

import UIKit

class ApplicationCoordinator: BaseCoordinator {
    
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        runMainFlow()
    }
    
    // MARK: - Flows

    private func runMainFlow() {
        let (coordinator, presentable) = coordinatorFactory.tabBarCoordinator()
        addDependency(coordinator)
        router.setRootModule(presentable, hideBar: true)
        coordinator.start()
    }
}
