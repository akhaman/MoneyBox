//
//  ExpenseDetailsManager.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import Foundation

protocol ExpenseDetailsManagerProtocol {
    func save(output: ExpenseDetails.ViewOutput)
    func loadState() -> ExpenseDetails.ViewState
}

class ExpenseDetailsManager: ExpenseDetailsManagerProtocol {

    private let repository: ExpensesRepositoryProtocol
    private let mode: ExpenseDetails.Mode
    private let category: Expense.Category

    private var loadedExpense: Expense?

    init(
        mode: ExpenseDetails.Mode = .new,
        category: Expense.Category,
        repository: ExpensesRepositoryProtocol = ExpensesRepository()
    ) {
        self.repository = repository
        self.category = category
        self.mode = mode
    }

    func save(output: ExpenseDetails.ViewOutput) {
        let expense: Expense?

        switch mode {
        case .new:
            expense = .new(category: category, sum: output.sum, comment: output.comment)
        case .editing:
            expense = loadedExpense.map { Expense(id: $0.id, category: $0.category, date: $0.date, sum: output.sum, comment: output.comment) }
        }

        guard let expense = expense else { return }

        repository.save(expense: expense)
    }

    func loadState() -> ExpenseDetails.ViewState {
        switch mode {
        case .new:
            return makeEmptyState()
        case .editing(let expenseId):
            let expense = repository.getExpense(byId: expenseId)
            self.loadedExpense = expense
            let state = expense.map(makeState(fromExpense:)) ?? makeEmptyState()
            return state
        }
    }
}

extension ExpenseDetailsManager {

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMMM"
        return formatter
    }()

    private func makeState(fromExpense expense: Expense) -> ExpenseDetails.ViewState {
        ExpenseDetails.ViewState(
            dateValue: expense.date.isToday ? "Сегодня" : Self.dateFormatter.string(from: expense.date),
            sumValue: expense.sum.description,
            commentValue: expense.comment
        )
    }

    private func makeEmptyState() -> ExpenseDetails.ViewState {
        ExpenseDetails.ViewState(dateValue: "", sumValue: "", commentValue: "")
    }
}
