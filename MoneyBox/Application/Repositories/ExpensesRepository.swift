//
//  ExpensesRepository.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import Foundation

protocol ExpensesRepositoryProtocol {
    func getExpenses() -> [Expense]
    func save(expense: Expense)
}

final class ExpensesRepository: ExpensesRepositoryProtocol {

    private let realmManager = RealmManager<Expense>()

    func getExpenses() -> [Expense] {
        realmManager.fetchAll()
    }

    func save(expense: Expense) {
        realmManager.write([expense])
    }
}
