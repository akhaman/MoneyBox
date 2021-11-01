//
//  ExpenseObject.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import RealmSwift
import Foundation

class PersistedExpense: Object {
    @Persisted var id: String
    @Persisted var category: Expense.Category
    @Persisted var date: Date
    @Persisted var sum: Int
    @Persisted var comment: String

    override class func primaryKey() -> String? {
        "id"
    }
}

extension Expense: PersistedModelsConvertible {
    typealias Persisted = PersistedExpense

    static func from(domain: Expense) -> PersistedExpense {
        let object = PersistedExpense()
        object.id = domain.id
        object.category = domain.category
        object.date = domain.date
        object.sum = domain.sum
        object.comment = domain.comment

        return object
    }

    static func from(persisted: PersistedExpense) -> Expense {
        Expense(
            id: persisted.id,
            category: persisted.category,
            date: persisted.date,
            sum: persisted.sum,
            comment: persisted.comment
        )
    }
}

extension Expense.Category: PersistableEnum {}
