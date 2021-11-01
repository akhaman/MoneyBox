//
//  RealmManager.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import RealmSwift

protocol PersistedModelsConvertible {
    associatedtype Persisted: Object

    static func from(persisted: Persisted) -> Self
    static func from(domain: Self) -> Persisted
}

// swiftlint:disable force_try
class RealmManager<T: PersistedModelsConvertible> {

    func write(_ models: [T]) {
        let realm: Realm = try! Realm()

        let persistedModels = models.map(T.from(domain:))

        try! realm.write {
            realm.add(persistedModels, update: .modified)
        }
    }

    func fetchAll() -> [T] {
        let realm: Realm = try! Realm()

        let result = realm.objects(T.Persisted.self).map(T.from(persisted:))
        return Array(result)
    }
}
