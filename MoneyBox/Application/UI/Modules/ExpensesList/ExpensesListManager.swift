//
//  ExpensesListManager.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import UIKit

protocol ExpensesListManagerProtocol {
    func loadExpenses()
    func observeStateChanges(_ completion: @escaping (ExpensesListViewState) -> Void)
}

class ExpensesListManager: ExpensesListManagerProtocol {

    private let repository: ExpensesRepositoryProtocol

    // MARK: - State

    private var onStateDidChange: ((ExpensesListViewState) -> Void)?

    private var state: ExpensesListViewState = .empty {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.onStateDidChange?(self.state)
            }
        }
    }

    // MARK: - Initialization

    init(repository: ExpensesRepositoryProtocol = ExpensesRepository()) {
        self.repository = repository
    }

    // MARK: - ExpensesListManagerProtocol

    func loadExpenses() {
        let state = makeState(from: repository.getExpenses())
        self.state = state
    }

    func observeStateChanges(_ completion: @escaping (ExpensesListViewState) -> Void) {
        onStateDidChange = completion
        repository.observeChanges { [weak self] expenses in
            guard let self = self else { return }
            self.state = self.makeState(from: expenses)
        }
    }
}

// MARK: - Helpers

extension ExpensesListManager {

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        return formatter
    }()

    private func makeState(from expenses: [Expense]) -> ExpensesListViewState {
        guard !expenses.isEmpty else { return .empty }

        let sumAmount = expenses.reduce(0) { $0 + $1.sum }.description
        let sumSection = ExpensesListViewState.Section(title: "Всего", .monthAmount(sumAmount))

        let dailyExpenses = expenses.groupedBy(dateComponents: .year, .month, .day)
            .sorted { $0.key < $1.key }
            .map(makeDailyExpense(fromDate: expensesInDay:))
            .map { ExpensesListViewState.Row.dailyExpenses($0) }

        let expensesSection = ExpensesListViewState.Section(items: dailyExpenses)
        
        return .loaded(sections: [sumSection, expensesSection])
    }

    private func makeDailyExpense(fromDate date: Date, expensesInDay: [Expense]) -> ExpensesListViewState.Daily {
        let formattedDate = Self.dateFormatter.string(from: date)

        let dailyAmount = expensesInDay.reduce(0) { $0 + $1.sum }.description

        let dailyExpenses = expensesInDay.groupedBy(keyPath: \.category)
            .sorted { $0.key > $1.key }
            .map(makeCategoryModel(fromCategory: expenses:))

        return ExpensesListViewState.Daily(date: formattedDate, amount: dailyAmount, expenseCategories: dailyExpenses)
    }

    private func makeCategoryModel(fromCategory category: Expense.Category, expenses: [Expense]) -> ExpensesListViewState.Category {
        ExpensesListViewState.Category(
            icon: category.icon,
            title: category.name,
            sumAmount: expenses.reduce(0) { $0 + $1.sum }.description
        )
    }
}
