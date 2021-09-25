//
//  ExpensesFlow.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import DITranquillity

protocol ExpensesFlow: Coordinatable {}

final class ExpensesFlowImpl: NavigationCoordinator, ExpensesFlow {
    
    private let container: DIContainer
    
    init(router: Routable, container: DIContainer) {
        self.container = container
        super.init(router: router)
    }
    
    override func start() {
        showExpensesList()
    }
    
    // MARK: - Run Current Flows Modules
    
    private func showExpensesList() {
        let module: ExpensesListModule = container.resolve()
        module.onAddExpenseTapped = { [weak self] in self?.runExpenseCreationFlow(onFinish: {}) }
        module.onExpenseTapped = { [weak self] in self?.showExpenseDetails(id: $0) }
        router.push(module, animated: false)
    }
    
    private func showExpenseDetails(id: Expenses.Id) {
        
    }
    
    // MARK: - Run Coordinators
    
    private func runExpenseCreationFlow(onFinish: @escaping VoidClosure) {
        let coordinator: ExpenseCreationFlow = container.resolve()
        addDependency(coordinator)
        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            onFinish()
        }
        router.present(coordinator)
        coordinator.start()
    }
}
