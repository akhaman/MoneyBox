//
//  ExpenseDetailsManager.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import Foundation

protocol ExpenseDetailsManagerProtocol {
    func save(expense: Expense)
}

class ExpenseDetailsManager: ExpenseDetailsManagerProtocol {

    private let repository: ExpensesRepositoryProtocol

    init(repository: ExpensesRepositoryProtocol = ExpensesRepository()) {
        self.repository = repository
    }

    func save(expense: Expense) {
        repository.save(expense: expense)
    }
}
