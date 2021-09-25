//
//  AppDependency.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 17.09.2021.
//

import DITranquillity
import SwiftLazy
import UIKit

enum AppDependency {
    static func configure() {
        DISetting.Defaults.injectToSubviews = false
        DISetting.Defaults.lifeTime = .prototype
        DISetting.Log.level = .none
        DISetting.Log.tab = "   "
    }

    static func register(inContainer container: DIContainer) {
        container.append(framework: CoordinatorsDI.self)

        validate(container: container)
    }

    private static func validate(container: DIContainer) {
        #if DEBUG
        guard container.makeGraph().checkIsValid(checkGraphCycles: false) else {
            fatalError("Di graph validation failed")
        }
        #endif
    }
}

final class CoordinatorsDI: DIFramework {
    static func load(container: DIContainer) {
        regiserFlows(in: container)
        registerModules(in: container)
        registerServices(in: container)
    }

    private static func regiserFlows(in container: DIContainer) {
        container.register { Router.init(navigationController: UINavigationController() ) }
            .as(Routable.self)

        container.register { TabBarController.init(nibName: nil, bundle: nil) }
            .as(TabBarModule.self)

        container.register { (container: DIContainer) -> ApplicationFlowImpl in
            let navigationСontroller = UINavigationController()
            navigationСontroller.setNavigationBarHidden(true, animated: false)
            return ApplicationFlowImpl(router: Router(navigationController: navigationСontroller), container: container)
        }
        .as(ApplicationFlow.self)

        container.register(MainTabBarFlowImpl.init)
            .as(MainTabBarFlow.self)

        container.register(ExpensesFlowImpl.init)
            .as(ExpensesFlow.self)

        container.register(ExpenseCreationFlowImpl.init)
            .as(ExpenseCreationFlow.self)

        container.register(BudgetFlowImpl.init)
            .as(BudgetFlow.self)
    }

    private static func registerModules(in container: DIContainer) {
        container.register { ExpensesListVC.init(nibName: nil, bundle: nil) }
            .as(ExpensesListModule.self)

        container.register { SelectCategoryVC.init(nibName: nil, bundle: nil) }
            .as(SelectCategoryModule.self)
    }

    private static func registerServices(in container: DIContainer) {
    }
}
