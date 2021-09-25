//
//  MainTabBarFlow.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import UIKit
import DITranquillity

protocol MainTabBarFlow: Coordinatable {}

final class MainTabBarFlowImpl: Coordinator, MainTabBarFlow {
    private let tabBarModule: TabBarModule
    private let container: DIContainer

    init(tabBarModule: TabBarModule, container: DIContainer) {
        self.tabBarModule = tabBarModule
        self.container = container
        super.init()
    }

    override var toPresent: UIViewController? {
        tabBarModule.toPresent
    }

    override func start() {
        let expenses: ExpensesFlow = container.resolve()
        let budget: BudgetFlow = container.resolve()

        [expenses, budget].forEach {
            $0.start()
            addDependency($0)
        }

        tabBarModule.configure(
            with: [
                .init(title: "Рвсходы", icon: Image.Icon.wallet.image, presentable: expenses) {},
                .init(title: "Бюджет", icon: Image.Icon.moneybag.image, presentable: budget) {}
            ],
            selectedIndex: 0
        )
    }
}
