//
//  Array+.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 03.11.2021.
//

import Foundation

extension Array {

    func groupedBy<T>(keyPath: KeyPath<Element, T>) -> [T: [Element]] {
        Dictionary(grouping: self) { element in
            element[keyPath: keyPath]
        }
    }
}
