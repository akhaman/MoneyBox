//
//  ExpenseCategory.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 25.09.2021.
//

import UIKit

struct Expense {
    let id: String
    let category: Category
    let date: Date
    let sum: Int
    let comment: String
}

extension Expense {

    static func new(category: Category, sum: Int, comment: String) -> Expense {
        Expense(id: UUID().uuidString, category: category, date: Date(), sum: sum, comment: comment)
    }
}
// MARK: - Category

extension Expense {

    enum Category: String {
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
}

extension Expense.Category {

    var name: String {
        switch self {
        case .home:
            return "Дом"
        case .food:
            return "Еда"
        case .transport:
            return "Транспорт"
        case .animals:
            return "Животные"
        case .credits:
            return "Кредиты"
        case .bills:
            return "Счета"
        case .savings:
            return "Накопления"
        case .purchases:
            return "Покупки"
        case .entertainment:
            return "Развлечения"
        case .beauty:
            return "Красота"
        case .health:
            return "Здоровье"
        case .children:
            return "Дети"
        case .travel:
            return "Путешествия"
        case .other:
            return "Другое"
        }
    }

    var icon: UIImage {
        switch self {
        case .home:
            return Image.Category.home.image
        case .food:
            return Image.Category.healthyFood.image
        case .transport:
            return Image.Category.ramp.image
        case .animals:
            return Image.Category.pawprint.image
        case .credits:
            return Image.Category.agreement.image
        case .bills:
            return Image.Category.invoice.image
        case .savings:
            return Image.Category.piggyBank.image
        case .purchases:
            return Image.Category.shoppingBag.image
        case .entertainment:
            return Image.Category.movies.image
        case .beauty:
            return Image.Category.beautySalon.image
        case .health:
            return Image.Category.hospital.image
        case .children:
            return Image.Category.nipple.image
        case .travel:
            return Image.Category.airplane.image
        case .other:
            return Image.Category.lamp.image
        }
    }
}
