//
//  ExpensesRepository.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import Foundation
import RealmSwift

protocol ExpensesRepositoryProtocol {
    func getExpenses() -> [Expense]
    func getExpense(byId expenseId: String) -> Expense?
    func getExpensesSortedByTimeInDay(withDate date: Date) -> [Expense]
    func save(expense: Expense)
    func observeChanges(_ completion: @escaping ([Expense]) -> Void) 
}

final class ExpensesRepository: ExpensesRepositoryProtocol {

    private let realmManager = RealmManager<Expense>()

    func getExpenses() -> [Expense] {
        realmManager.fetchAll()
    }

    func getExpense(byId expenseId: String) -> Expense? {
        realmManager.fetch(byId: expenseId)
    }

    func save(expense: Expense) {
        realmManager.write([expense])
    }

    func getExpensesSortedByTimeInDay(withDate date: Date) -> [Expense] {
        let predicate = NSPredicate(format: "date BETWEEN %@", [date.startOfDay, date.endOfDay] as [NSDate])
        let sortDescriptor = SortDescriptor(keyPath: "date")

        return realmManager.fetch(predicate: predicate, sortDescriptors: sortDescriptor)
    }

    func observeChanges(_ completion: @escaping ([Expense]) -> Void) {
        realmManager.observeChanges(completion: completion)
    }
}
