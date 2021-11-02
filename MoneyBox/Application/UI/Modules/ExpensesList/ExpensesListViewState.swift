//
//  ExpensesListViewState.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import UIKit

enum ExpensesListViewState {
    case empty
    case loaded(sections: [Section])
}

extension ExpensesListViewState {

    typealias Section = SectionModel<Row>

    enum Row {
        case monthAmount(String)
        case dailyExpenses(Daily)
    }

    struct Daily {
        let date: Date
        let stringDate: String
        let amount: String
        let expenseCategories: [Category]
    }

    struct Category {
        let icon: UIImage
        let title: String
        let sumAmount: String
    }
}
