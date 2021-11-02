//
//  ExpensesListVC.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit

class ExpensesListVC: UIViewController {

    // MARK: - Properties

    private let expensesListView = ExpensesListView()
    private let manager: ExpensesListManagerProtocol

    // MARK: - Initialization

    init(manager: ExpensesListManagerProtocol) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        view = expensesListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDataObservation()
    }

    // MARK: - Setup

    private func setupView() {
        title = "Расходы"
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Image.Icon.add.image,
            style: .plain,
            target: self,
            action: #selector(openAddExpense)
        )
        
        expensesListView.addExpenseTapped = { [weak self] in self?.openAddExpense() }
        expensesListView.onSelectDailyReview = { [weak self] in self?.showExpensesInDay(date: $0.date, title: $0.stringDate) }
    }

    // MARK: - Data Loading

    private func setupDataObservation() {
        manager.observeStateChanges { [weak self] state in
            self?.expensesListView.update(state: state)
        }
        
        manager.loadExpenses()
    }

    // MARK: - Navigation

    @objc private func openAddExpense() {
        let selectCategoryController = SelectCategoryVC()
        let navigationController = UINavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        navigationController.pushViewController(selectCategoryController, animated: false)
        present(navigationController, animated: true)
    }

    private func showExpensesInDay(date: Date, title: String) {
        let manager = DailyExpensesListManager(date: date)
        let viewController = DailyExpensesListVC(manager: manager, title: title)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
