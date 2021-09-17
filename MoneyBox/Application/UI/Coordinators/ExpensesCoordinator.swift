//
//  ExpensesCoordinator.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import Foundation

final class ExpensesCoordinator: BaseCoordinator {
    
    private let moduleFactory: ModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(router: Router, coordinatorFactory: CoordinatorFactory, moduleFactory: ModuleFactory) {
        self.router = router
        self.moduleFactory =  moduleFactory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showExpensesList()
    }
    
    // MARK: - Run Current Flows Modules
    
    private func showExpensesList() {
        var (module, presentable) = moduleFactory.expensesList()
        module.onAddExpenseTapped = { [weak self] in self?.runExpenseCreationFlow(onFinish: {}) }
        module.onExpenseTapped = { [weak self] in self?.showExpenseDetails(id: $0) }
        router.push(presentable, animated: false)
    }
    
    private func showExpenseDetails(id: Expenses.Id) {
        
    }
    
    // MARK: - Run Coordinators
    
    private func runExpenseCreationFlow(onFinish: @escaping VoidClosure) {
        let (coordinator, presentable) = coordinatorFactory.expenseCreationCoordinator()
        addDependency(coordinator)
        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            onFinish()
        }
        router.present(presentable)
        coordinator.start()
    }
}
