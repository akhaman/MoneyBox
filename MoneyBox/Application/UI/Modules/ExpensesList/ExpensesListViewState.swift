//
//  ExpensesListViewModel.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import UIKit

struct ExpensesListViewState {
    let sections: [Section]

    var isEmpty: Bool { sections.isEmpty }
}

extension ExpensesListViewState {

    typealias Section = SectionModel<Row>

//    struct DailyExpenses {
//        let date: String
//        let expenseCategories: [Category]
//    }

    enum Row {
        case monthAmount(String)
        case dailyExpenses(Daily)
    }

    struct Daily {
        let date: String
        let amount: String
        let expenseCategories: [Category]
    }

    struct Category {
        let icon: UIImage
        let title: String
        let sumAmount: String
    }
}
