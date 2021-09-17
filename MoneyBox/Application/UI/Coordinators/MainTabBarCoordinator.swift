//
//  MainTabBarCoordinator.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import UIKit

protocol MainTabBarCoordinatorOutput {}

final class MainTabBarCoordinator: BaseCoordinator, MainTabBarCoordinatorOutput  {

    private var tabBarModule: TabBarModule
    private let coordinatorFactory: CoordinatorFactory

    init(tabBarModule: TabBarModule, coordinatorFactory: CoordinatorFactory) {
        self.tabBarModule = tabBarModule
        self.coordinatorFactory = coordinatorFactory
        super.init()
    }
    
    override func start() {
        tabBarModule.set(onExpensesFlowRun: runExpensesFlow, onBudgetFlowRun: runBudgetFlow)
    }
    
    private lazy var runExpensesFlow: (UINavigationController) -> Void = { [weak self] in
        guard let self = self else { return }
        let coordinator = self.coordinatorFactory.expensesCoordinator(navigationController: $0)
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private lazy var runBudgetFlow: (UINavigationController) -> Void = { [weak self] in
        guard let self = self else { return }
        let coordinator = self.coordinatorFactory.budgetCoordinator(navigationController: $0)
        self.addDependency(coordinator)
        coordinator.start()
    }
}
