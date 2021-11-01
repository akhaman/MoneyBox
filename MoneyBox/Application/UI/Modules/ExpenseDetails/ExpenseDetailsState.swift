//
//  ExpenseDetailsState.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 01.11.2021.
//

import Foundation

struct ExpenseDetails {
    
    enum Mode {
        case new
        case editing(expenseId: String)
    }

    struct ViewState {
        let dateValue: String
        let sumValue: String
        let commentValue: String
    }

    struct ViewOutput {
        let sum: Int
        let comment: String

        init?(sum: String?, comment: String?) {
            guard let sum = sum,
                  let intSum = Int(sum),
                  let comment = comment else { return nil }

            self.sum = intSum
            self.comment = comment
        }
    }
}
