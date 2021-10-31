//
//  ExpenseCategory.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 25.09.2021.
//

import UIKit

struct Expense {
    let category: Category
    let date: Date
    let sum: Int
    let comment: String
}

// MARK: - Category

extension Expense {
    enum Category: String {
        case home
    }
}

extension Expense.Category {

    var name: String {
        switch self {
        case .home:
            return "Дом"
        }
    }

    var icon: UIImage {
        switch self {
        case .home:
            return Image.Category.home.image
        }
    }
}
