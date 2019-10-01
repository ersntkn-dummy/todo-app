//
//  TodoListFactory.swift
//  TodoApp
//
//  Created by Ersen Tekin on 29/09/2019.
//  Copyright © 2019 Ersen Tekin. All rights reserved.
//

import UIKit
import RealmSwift

enum TodoListFactoryError: Error {
    case storyboardInstantiation(identifier: String)
}

struct TodoListFactory {
    static func createTodoListModule() throws -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationControllerId = "TodoListNavigationController"
        guard let navigationController = storyboard.instantiateViewController(
                withIdentifier: navigationControllerId) as? UINavigationController else {
            throw TodoListFactoryError.storyboardInstantiation(identifier: navigationControllerId)
        }

        let viewControllerId = "TodoListViewController"
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "TodoListViewController") as? TodoListViewController else {
            throw TodoListFactoryError.storyboardInstantiation(identifier: viewControllerId)
        }

// swiftlint:disable:next force_try
        let realm = try! Realm()
        let database = RealmDatabaseManager(realm: realm)
        viewController.presenter = TodoListPresenter(databaseManager: database)
        viewController.presenter.delegate = viewController
        navigationController.setViewControllers([viewController], animated: false)

        return navigationController
    }
}
