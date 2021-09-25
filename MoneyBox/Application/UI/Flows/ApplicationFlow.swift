//
//  ApplicationFlow.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 11.09.2021.
//

import DITranquillity

protocol ApplicationFlow: Coordinatable {
}

class ApplicationFlowImpl: NavigationCoordinator, ApplicationFlow {
    
    private let container: DIContainer
    
    init(router: Routable, container: DIContainer) {
        self.container = container
        super.init(router: router)
    }
    
    override func start() {
        runMainFlow()
    }
    
    // MARK: - Flows

    private func runMainFlow() {
        let coordinator: MainTabBarFlow = container.resolve()
        addDependency(coordinator)
        router.setRootModule(coordinator, isNavigationBarHidden: true)
        coordinator.start()
    }
}
