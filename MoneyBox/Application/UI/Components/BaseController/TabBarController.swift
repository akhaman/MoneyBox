//
//  TabBarController.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import UIKit

protocol TabBarModule {
    typealias NavigationClosuse = (_ rootController: UINavigationController) -> Void
    
    func set(onExpensesFlowRun: @escaping NavigationClosuse, onBudgetFlowRun: @escaping NavigationClosuse)
}

final class TabBarController: UITabBarController, TabBarModule {
   
    private var onExpensesFlowRun: NavigationClosuse?
    private var onBudgetFlowRun: NavigationClosuse?
    
    func set(onExpensesFlowRun: @escaping NavigationClosuse, onBudgetFlowRun: @escaping NavigationClosuse) {
        self.onExpensesFlowRun = onExpensesFlowRun
        self.onBudgetFlowRun = onBudgetFlowRun
        setup()
    }
    
    private func setup() {
        delegate = self
        let expenses = rootController(from: .expenses)
        let budget = rootController(from: .budget)
        onExpensesFlowRun?(expenses)
        setViewControllers([expenses, budget], animated: false)
    }
    
    private func rootController(from item: Item) -> UINavigationController {
        let controller = UINavigationController()
        
        switch item {
        case .expenses:
            controller.tabBarItem.title = "Расходы"
            controller.tabBarItem.image = Image.Icon.wallet.image
        case .budget:
            controller.tabBarItem.title = "Бюджет"
            controller.tabBarItem.image = Image.Icon.moneybag.image
        }
        
        return controller
    }
    
    enum Item: Int {
        case expenses
        case budget
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let rootController = viewControllers?[selectedIndex] as? UINavigationController,
              rootController.viewControllers.isEmpty else { return }
        
        switch Item(rawValue: selectedIndex) {
        case .expenses:
            onExpensesFlowRun?(rootController)
        case .budget:
            onBudgetFlowRun?(rootController)
        case .none:
            break
        }
    }
}
