//
//  AppDelegate.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow()
        self.window = window
        let navigationController = UINavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        let expensesListVC = ExpensesListVC(manager: ExpensesListManager())
        navigationController.pushViewController(expensesListVC, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
    }
}
