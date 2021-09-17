//
//  Dependensies.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 11.09.2021.
//

import UIKit

private class DI {

    static let shared: DI = DI()
    private init() {}
    
    lazy var coordinatorFactory: CoordinatorFactory = CoordinatorFactoryImpl()
    lazy var moduleFactory: ModuleFactory = ModuleFactoryImpl()
}

// MARK: - Application Factory

protocol ApplicationFactory {
    
    func makeWindowWithCoordinator() -> (UIWindow, Coordinator)
}

final class ApplicationFactoryImpl: ApplicationFactory {
   
    func makeWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootNavigationController = UINavigationController()
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        let router = RouterImpl(rootController: rootNavigationController)
        let applicationCoordinator = ApplicationCoordinator(router: router, coordinatorFactory: DI.shared.coordinatorFactory)
        return (window, applicationCoordinator)
    }
}

// MARK: - Coordinator Factory

protocol CoordinatorFactory {
    func tabBarCoordinator() -> (Coordinator, Presentable)
    func expensesCoordinator(navigationController: UINavigationController) -> Coordinator
    func budgetCoordinator(navigationController: UINavigationController) -> Coordinator
    func expenseCreationCoordinator() -> (ExpenseCreationCoordinator, Presentable)
}

final class CoordinatorFactoryImpl: CoordinatorFactory {

    func tabBarCoordinator() -> (Coordinator, Presentable) {
        let tabBarController = TabBarController()
        let tabBarCoordinator = MainTabBarCoordinator(
            tabBarModule: tabBarController,
            coordinatorFactory: DI.shared.coordinatorFactory
        )
        return (tabBarCoordinator, tabBarController)
    }
    
    func expensesCoordinator(navigationController: UINavigationController) -> Coordinator {
        let coordinator = ExpensesCoordinator(
            router: RouterImpl(rootController: navigationController),
            coordinatorFactory: DI.shared.coordinatorFactory,
            moduleFactory: DI.shared.moduleFactory
        )
        
        return coordinator
    }
    
    func budgetCoordinator(navigationController: UINavigationController) -> Coordinator {
        let coordinator = BudgetCoordinator()
        return coordinator
    }
    
    func expenseCreationCoordinator() -> (ExpenseCreationCoordinator, Presentable) {
        let navigationController = UINavigationController()
        let router = RouterImpl(rootController: navigationController)
        let coordinator = ExpenseCreationCoordinatorImpl(
            router: router,
            moduleFactory: DI.shared.moduleFactory
        )
        
        return (coordinator, navigationController)
    }
}

// MARK: - ModuleFactory

protocol ModuleFactory {
    
    func expensesList() -> (ExpensesListModule, Presentable)
    func selectCategory() -> (SelectCategoryModule, Presentable)
}

final class ModuleFactoryImpl: ModuleFactory {
    
    func expensesList() -> (ExpensesListModule, Presentable) {
        let controller = ExpensesListVC(view: ExpensesListView())
        return (controller, controller)
    }
    
    func selectCategory() -> (SelectCategoryModule, Presentable) {
        let controller = SelectCategoryVC()
        return (controller, controller)
    }
}
