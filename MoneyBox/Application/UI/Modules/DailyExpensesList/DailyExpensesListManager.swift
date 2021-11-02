//
//  DailyExpensesListManager.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 02.11.2021.
//

import Foundation

protocol DailyExpensesListManagerProtocol {
    func loadExpenses()
    func observe(onExpensesDidLoad: @escaping ([DailyExpensesListItem]) -> Void)
}

class DailyExpensesListManager {

    // MARK: - Dependencies

    private let repository: ExpensesRepositoryProtocol
    private let date: Date

    // MARK: - Properties

    private var onExpensesDidLoad: (([DailyExpensesListItem]) -> Void)?
    private var expenses: [Expense] = [] {
        didSet {
            onExpensesDidLoad?(makeItems(from: expenses))
        }
    }

    // MARK: - Initialization

    init(date: Date, repository: ExpensesRepositoryProtocol = ExpensesRepository()) {
        self.date = date
        self.repository = repository
    }
}

// MARK: - DailyExpensesListManagerProtocol

extension DailyExpensesListManager: DailyExpensesListManagerProtocol {

    func loadExpenses() {
        expenses = repository.getExpensesSortedByTimeInDay(withDate: date)
    }

    func observe(onExpensesDidLoad: @escaping ([DailyExpensesListItem]) -> Void) {
        self.onExpensesDidLoad = onExpensesDidLoad
        repository.observeChanges { [weak self] in self?.expenses = $0 }
    }
}

// MARK: - Helpers

extension DailyExpensesListManager {

    private func makeItems(from expenses: [Expense]) -> [DailyExpensesListItem] {

        var items: [DailyExpensesListItem] = expenses.map {
            DailyExpensesListItem.Expense(
                id: $0.id,
                category: $0.category,
                icon: $0.category.icon,
                name: $0.category.name,
                sumAmount: $0.sum.description,
                comment: $0.comment
            )
        }
        .map { .expense($0) }

        let amount = expenses.reduce(0) { $0 + $1.sum }
        items.insert(.amount(amount.description), at: 0)

        return items
    }
}
