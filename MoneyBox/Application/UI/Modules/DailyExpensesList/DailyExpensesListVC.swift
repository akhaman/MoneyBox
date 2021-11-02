//
//  DailyExpensesListVC.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 02.11.2021.
//

import UIKit

final class DailyExpensesListVC: UIViewController {

    // MARK: - Subviews

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HeaderAmountCell.self, DailyExpenseCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Dependencies

    private let manager: DailyExpensesListManagerProtocol

    // MARK: - Initialization

    init(manager: DailyExpensesListManagerProtocol, title: String) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - State

    private var items: [DailyExpensesListItem] = []

    // MARK: - Life Cycle

    override func loadView() {
        view = GradientView.mainBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDataObservation()
        manager.loadExpenses()
    }

    // MARK: - Setup

    private func setupView() {
        navigationItem.backButtonTitle = ""
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupDataObservation() {
        manager.observe { [weak self] items in
            self?.items = items
            self?.tableView.reloadData()
        }
    }

    // MARK: - Navigation

    private func showDetails(withExpenseId id: String, category: Expense.Category) {
        let manager = ExpenseDetailsManager(mode: .editing(expenseId: id), category: category)
        let viewController = ExpenseDetailsVC(category: category, manager: manager)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension DailyExpensesListVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]

        switch item {
        case .amount(let amount):
            return tableView.dequeue(HeaderAmountCell.self).update(withAmount: amount)
        case .expense(let expense):
            return tableView.dequeue(DailyExpenseCell.self).update(with: expense)
        }
    }
}

// MARK: - UITableViewDelegate

extension DailyExpensesListVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]

        switch item {
        case .amount:
            break
        case .expense(let expense):
            showDetails(withExpenseId: expense.id, category: expense.category)
        }
    }
}
