//
//  ExpenseCreationCoordinator.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import Foundation

protocol ExpenseCreationCoordinator: Coordinator {
    
    var finishFlow: VoidClosure? { get set }
}

final class ExpenseCreationCoordinatorImpl: BaseCoordinator, ExpenseCreationCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let router: Router
    private let moduleFactory: ModuleFactory
    
    init(router: Router, moduleFactory: ModuleFactory) {
        self.router = router
        self.moduleFactory = moduleFactory
    }
    
    override func start() {
        showSelectCategory()
    }
    
    private func showSelectCategory() {
        let (module, presentable) = moduleFactory.selectCategory()
        module.onSelectCategory = { _ in }
        router.setRootModule(presentable)
    }
}
