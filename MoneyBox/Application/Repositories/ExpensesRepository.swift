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
    func observeChanges(_ completion: @escaping ([Expense]) -> Void) 
}

final class ExpensesRepository: ExpensesRepositoryProtocol {

    private let realmManager = RealmManager<Expense>()

    func getExpenses() -> [Expense] {
        realmManager.fetchAll()
    }

    func save(expense: Expense) {
        realmManager.write([expense])
    }

    func observeChanges(_ completion: @escaping ([Expense]) -> Void) {
        realmManager.observeChanges(completion: completion)
    }
}
