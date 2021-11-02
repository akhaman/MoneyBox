//
//  ExpensesListVC.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit

class ExpensesListVC: UIViewController {

    // MARK: - Subviews

    private lazy var expensesListView = DailyReviewListView()
    private lazy var infoView = InfoView()

    // MARK: - Dependencies

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
        title = "Расходы"
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Image.Icon.add.image,
            style: .plain,
            target: self,
            action: #selector(openAddExpense)
        )

        view.addSubview(expensesListView)
        expensesListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        expensesListView.onSelectDailyReview = { [weak self] in
            self?.showExpensesInDay(date: $0.date, title: $0.stringDate)
        }

        view.addSubview(infoView)
        infoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        infoView.onAddButtonDidTap = { [weak self] in
            self?.openAddExpense()
        }
    }

    // MARK: - Data Loading

    private func setupDataObservation() {
        manager.observeStateChanges { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .empty:
                self.infoView.show()
                self.expensesListView.hide()
            case .loaded(let sections):
                self.infoView.hide()
                self.expensesListView.show()
                self.expensesListView.update(with: sections)
            }
        }
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
