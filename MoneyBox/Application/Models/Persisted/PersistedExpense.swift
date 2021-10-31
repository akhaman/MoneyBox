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
    @Persisted var category: PersistedExpenseCategory
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
        object.category = .from(category: domain.category)
        object.date = domain.date
        object.sum = domain.sum
        object.comment = domain.comment

        return object
    }

    static func from(persisted: PersistedExpense) -> Expense {
        Expense(
            id: persisted.id,
            category: .from(persisted: persisted.category),
            date: persisted.date,
            sum: persisted.sum,
            comment: persisted.comment
        )
    }
}

enum PersistedExpenseCategory: String, PersistableEnum {
    case home
    case food
    case transport
    case animals
    case credits
    case bills
    case savings
    case purchases
    case entertainment
    case beauty
    case health
    case children
    case travel
    case other
}

extension PersistedExpenseCategory {

    static func from(category: Expense.Category) -> PersistedExpenseCategory {
        PersistedExpenseCategory(rawValue: category.rawValue) ?? .other
    }
}

extension Expense.Category {

    static func from(persisted: PersistedExpenseCategory) -> Expense.Category {
        Expense.Category(rawValue: persisted.rawValue) ?? .other
    }
}
