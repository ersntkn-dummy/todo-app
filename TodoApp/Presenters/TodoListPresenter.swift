//
//  TodoListPresenter.swift
//  TodoApp
//
//  Created by Ersen Tekin on 29/09/2019.
//  Copyright © 2019 Ersen Tekin. All rights reserved.
//

import UIKit

protocol TodoListPresenterDelegate: class {
    func didFinishFetchItems()
    func didFinishUpdate()
}

final class TodoListPresenter {
    weak var delegate: TodoListPresenterDelegate?
    private let databaseManager: DatabaseManager
    private(set) var todoItems = [TodoItem]()
    private(set) var doneItems = [TodoItem]()

    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }

    func fetchItems() {
        let allItems = self.databaseManager.fetchTodoItems()
        todoItems = allItems.filter { $0.isDone == false }
        doneItems = allItems.filter { $0.isDone == true }

        delegate?.didFinishFetchItems()
    }

    func deleteItem(item: TodoItem) {
        databaseManager.deleteItem(item: item) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didFinishUpdate()
        }
    }

    func addItem(text: String) {
        let item = TodoItem(value: [ "text": text, "isDone": false ])
        databaseManager.addTodoItem(item: item) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didFinishUpdate()
        }
    }

    func toggleItem(item: TodoItem) {
        let updateBlock = { item.isDone = !item.isDone }
        databaseManager.updateItem(updateBlock: updateBlock) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didFinishUpdate()
        }
    }

    func provideAddView() -> UIViewController {
        let alertController = UIAlertController(title: "New item", message: nil, preferredStyle: .alert)
        alertController.addTextField()

        let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned alertController] _ in
            if let text = alertController.textFields![0].text, text.count > 0 {
                self.addItem(text: text)
            }
        }

        alertController.addAction(submitAction)
        return alertController
    }
}
