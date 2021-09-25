//
//  Section.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import Foundation

struct Section<Item> {
    let title: String?
    var items: [Item]

    init(title: String? = nil, items: [Item] = []) {
        self.title = title
        self.items = items
    }

    init(title: String? = nil, _ items: Item...) {
        self.title = title
        self.items = items
    }
}
