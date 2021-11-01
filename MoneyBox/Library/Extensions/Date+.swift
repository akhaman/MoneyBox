//
//  Date+.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import Foundation

protocol Dated {
    var date: Date { get }
}

extension Array where Element: Dated {

    func groupedBy(dateComponents: Calendar.Component...) -> [Date: [Element]] {
        groupedBy(dateComponents: Set(dateComponents))
    }

    func groupedBy(dateComponents: Set<Calendar.Component>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]

        let groupedByDateComponents = reduce(into: initial) { dateMap, element in
            let components = Calendar.current.dateComponents(dateComponents, from: element.date)

            guard let date = Calendar.current.date(from: components) else {
                return assertionFailure("Incorrect date")
            }

            let existingElements = dateMap[date] ?? []
            dateMap[date] = existingElements + [element]
        }

        return groupedByDateComponents
    }
}

extension Date {

    func equals(with anotherDate: Date, by dateComponents: Calendar.Component...) -> Bool {
        let componentsSet = Set(dateComponents)
        let selfComponents = Calendar.current.dateComponents(componentsSet, from: self)
        let anotherComponents = Calendar.current.dateComponents(componentsSet, from: anotherDate)

        return selfComponents == anotherComponents
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    static var now: Date {
        Date()
    }
}

extension Array {

    func groupedBy<T>(keyPath: KeyPath<Element, T>) -> [T: [Element]] {
        Dictionary(grouping: self) { element in
            element[keyPath: keyPath]
        }
    }
}