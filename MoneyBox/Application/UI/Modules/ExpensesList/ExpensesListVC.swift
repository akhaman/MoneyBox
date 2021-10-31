//
//  ExpensesListVC.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit

class ExpensesListVC: UIViewController {

    // MARK: - Properties

    let homeView = ExpensesListView()

    // MARK: - Life Cycle

    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Setup

    private func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Image.Icon.add.image,
            style: .plain,
            target: self,
            action: #selector(openAddExpense)
        )
        homeView.addExpenseTapped = { [weak self] in self?.openAddExpense() }
        homeView.update(with: [])
        title = "Расходы"
    }

    @objc private func openAddExpense() {
        let selectCategoryController = SelectCategoryVC()
        let navigationController = UINavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        navigationController.pushViewController(selectCategoryController, animated: false)
        present(navigationController, animated: true)
    }
}
