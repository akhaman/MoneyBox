//
//  DailyExpensesListState.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 02.11.2021.
//

import UIKit

enum DailyExpensesListItem {
    case amount(String)
    case expense(Expense)

    struct Expense {
        let id: String
        let category: MoneyBox.Expense.Category
        let icon: UIImage
        let name: String
        let sumAmount: String
        let comment: String
    }
}
