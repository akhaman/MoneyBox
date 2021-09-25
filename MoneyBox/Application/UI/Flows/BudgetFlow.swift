//
//  BudgetFlow.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import DITranquillity

protocol BudgetFlow: Coordinatable {}

final class BudgetFlowImpl: NavigationCoordinator, BudgetFlow {
    
    private let container: DIContainer
    
    init(router: Routable, container: DIContainer) {
        self.container = container
        super.init(router: router)
    }
}
