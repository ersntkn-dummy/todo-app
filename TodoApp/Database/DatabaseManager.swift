//
//  DatabaseManager.swift
//  TodoApp
//
//  Created by Ersen Tekin on 29/09/2019.
//  Copyright © 2019 Ersen Tekin. All rights reserved.
//

import RealmSwift

protocol DatabaseManager {
    func fetchTodoItems() -> [TodoItem]
    func addTodoItem(item: TodoItem, completion: @escaping () -> Void)
    func deleteItem(item: TodoItem, completion: @escaping () -> Void)
    func updateItem(updateBlock: () -> Void, completion: @escaping () -> Void)
}

final class RealmDatabaseManager: DatabaseManager {

    private let realm: Realm
    private var token: NotificationToken?

    init(realm: Realm) {
        self.realm = realm
    }

    func fetchTodoItems() -> [TodoItem] {
        let items = realm.objects(TodoItem.self)
        return items.map { $0 }
    }

    func addTodoItem(item: TodoItem, completion: @escaping () -> Void) {
        self.token = realm.observe { _, _ in
            completion()
        }
// swiftlint:disable:next force_try
        try! realm.write {
            realm.add(item)
        }

        self.token?.invalidate()
    }

    func deleteItem(item: TodoItem, completion: @escaping () -> Void) {
        self.token = realm.observe { _, _ in
            completion()
        }
// swiftlint:disable:next force_try
        try! realm.write {
            realm.delete(item)
        }

        self.token?.invalidate()
    }

    func updateItem(updateBlock: () -> Void, completion: @escaping () -> Void) {
        self.token = realm.observe { _, _ in
            completion()
        }

// swiftlint:disable:next force_try
        try! realm.write {
            updateBlock()
        }

        self.token?.invalidate()
    }
}
