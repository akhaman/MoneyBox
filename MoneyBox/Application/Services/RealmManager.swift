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

    private var token: NotificationToken?

    func write(_ models: [T]) {
        let realm = try! Realm()

        let persistedModels = models.map(T.from(domain:))

        try! realm.write {
            realm.add(persistedModels, update: .modified)
        }
    }

    func fetchAll() -> [T] {
        let realm = try! Realm()

        let result = realm.objects(T.Persisted.self).map(T.from(persisted:))
        return Array(result)
    }

    func fetchFirst(byId id: String) -> T? {
        let realm = try! Realm()

        let result = realm.object(ofType: T.Persisted.self, forPrimaryKey: id).map(T.from(persisted:))
        return result
    }

    func observeChanges(completion: @escaping ([T]) -> Void) {
        let realm = try! Realm()

        token = realm.observe { notification, realm in
            guard notification == .didChange else { return }
            
            let result = realm.objects(T.Persisted.self).map(T.from(persisted:))
            completion(Array(result))
        }
    }
}
