//
//  RealmManager.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import RealmSwift
import Foundation

protocol PersistedModelsConvertible {
    associatedtype Persisted: Object

    static func from(persisted: Persisted) -> Self
    static func from(domain: Self) -> Persisted
}

typealias SortDescriptor = RealmSwift.SortDescriptor

// swiftlint:disable force_try
class RealmManager<T: PersistedModelsConvertible> {

    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))

    private var token: NotificationToken?

    func write(_ models: [T]) {
        let persistedModels = models.map(T.from(domain:))

        try! realm.write {
            realm.add(persistedModels, update: .modified)
        }
    }

    func fetchAll() -> [T] {
        let result = realm.objects(T.Persisted.self).map(T.from(persisted:))
        return Array(result)
    }

    func fetch(byId id: String) -> T? {
        realm.object(ofType: T.Persisted.self, forPrimaryKey: id).map(T.from(persisted:))
    }

    func fetch(predicate: NSPredicate, sortDescriptors: SortDescriptor...) -> [T] {
        let result = realm.objects(T.Persisted.self)
            .filter(predicate)
            .sorted(by: sortDescriptors)
            .map(T.from(persisted:))

        return Array(result)
    }

    func observeChanges(completion: @escaping ([T]) -> Void) {
        token = realm.observe { notification, realm in
            guard notification == .didChange else { return }
            
            let result = realm.objects(T.Persisted.self).map(T.from(persisted:))
            completion(Array(result))
        }
    }
}
