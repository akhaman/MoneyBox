//
//  ExpenseCreationFlow.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import DITranquillity

protocol ExpenseCreationFlow: Coordinatable {
    var finishFlow: VoidClosure? { get set }
}

final class ExpenseCreationFlowImpl: NavigationCoordinator, ExpenseCreationFlow {
    
    var finishFlow: VoidClosure?
    private let container: DIContainer
    
    init(router: Routable, container: DIContainer) {
        self.container = container
        super.init(router: router)
    }
    
    override func start() {
        showSelectCategory()
    }
    
    private func showSelectCategory() {
        let module: SelectCategoryModule = container.resolve()
        module.onSelectCategory = { _ in }
        router.setRootModule(module)
    }
}
