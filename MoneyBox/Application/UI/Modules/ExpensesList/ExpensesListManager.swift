//
//  ExpensesListManager.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import UIKit

protocol ExpensesListManagerProtocol {
    func loadExpenses() -> ExpensesListViewState
}

class ExpensesListManager: ExpensesListManagerProtocol {

    private let repository: ExpensesRepositoryProtocol

    init(repository: ExpensesRepositoryProtocol = ExpensesRepository()) {
        self.repository = repository
    }

    func loadExpenses() -> ExpensesListViewState {
        viewModel(from: repository.getExpenses())
    }
}

extension ExpensesListManager {

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        return formatter
    }()

    private func viewModel(from expenses: [Expense]) -> ExpensesListViewState {

        let sumAmount = expenses.reduce(0) { $0 + $1.sum }.description
        let sumSection = ExpensesListViewState.Section(title: "Всего", .monthAmount(sumAmount))

        let dailyExpenses = expenses.groupedBy(dateComponents: .year, .month, .day)
            .sorted { $0.key < $1.key }
            .map(dailyExpense(fromDate: expensesInDay:))
            .map { ExpensesListViewState.Row.dailyExpenses($0) }

        let expensesSection = ExpensesListViewState.Section(items: dailyExpenses)
        
        return ExpensesListViewState(sections: [sumSection, expensesSection])
    }

    private func dailyExpense(fromDate date: Date, expensesInDay: [Expense]) -> ExpensesListViewState.Daily {
        let formattedDate = Self.dateFormatter.string(from: date)

        let dailyAmount = expensesInDay.reduce(0) { $0 + $1.sum }.description

        let dailyExpenses = expensesInDay.groupedBy(keyPath: \.category)
            .sorted { $0.key > $1.key }
            .map(categoryViewModel(fromCategory: expenses:))

        return ExpensesListViewState.Daily(date: formattedDate, amount: dailyAmount, expenseCategories: dailyExpenses)
    }

    private func categoryViewModel(fromCategory category: Expense.Category, expenses: [Expense]) -> ExpensesListViewState.Category {
        ExpensesListViewState.Category(
            icon: category.icon,
            title: category.name,
            sumAmount: expenses.reduce(0) { $0 + $1.sum }.description
        )
    }
}
