//
//  File.swift
//  TodoAppTests
//
//  Created by Ersen Tekin on 29/09/2019.
//  Copyright © 2019 Ersen Tekin. All rights reserved.
//

import Foundation
@testable import TodoApp

final class MockDatabaseManager: DatabaseManager {

    static let fetchedItemText = "anyTodo"

    var addedItem: TodoItem?
    var deletedItem: TodoItem?
    var calledFetchTodoItems = false
    var calledUpdateItem = false

    func addTodoItem(item: TodoItem, completion: @escaping () -> Void) {
        addedItem = item
        completion()
    }

    func deleteItem(item: TodoItem, completion: @escaping () -> Void) {
        deletedItem = item
        completion()
    }

    func fetchTodoItems() -> [TodoItem] {
        calledFetchTodoItems = true
        return [TodoItem(value: [ "text": MockDatabaseManager.fetchedItemText, "isDone": false ])]
    }

    func updateItem(updateBlock: () -> Void, completion: @escaping () -> Void) {
        calledUpdateItem = true
        updateBlock()
        completion()
    }
}
