//
//  ExpensesListVC.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit

protocol ExpensesListModule: Presentable {
    var onAddExpenseTapped: VoidClosure? { get set }
    var onExpenseTapped: ((_ expenseId: Expenses.Id) -> Void)? { get set }
}

enum Expenses {
    typealias Id = String
}

class ExpensesListVC: UIViewController, ExpensesListModule {
    // MARK: - Callbacks

    var onAddExpenseTapped: VoidClosure?
    var onExpenseTapped: ((Expenses.Id) -> Void)?

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
        let onAddExpenseTapped = self.onAddExpenseTapped ?? {}
        navigationItem.rightBarButtonItem = BarButtonItem(type: .add, onTap: onAddExpenseTapped)
        homeView.addExpenseTapped = onAddExpenseTapped
        homeView.update(with: sections)
        title = "Расходы"
    }

    private var sections: [HomeListSection] {
        [
            HomeListSection(title: "Март", .monthAmount("100₽")),
            HomeListSection(.dailyExpenses(dailyModel))
        ]
    }

    var dailyModel: DailyReviewModel {
        .init(
            date: "15 марта",
            amount: "100₽",
            expenses: [
                .init(icon: Image.Category.airplane.image, title: "Заголовок", sumAmount: "100₽")
            ]
        ) { [weak self] in self?.onExpenseTapped?("") }
    }
}
