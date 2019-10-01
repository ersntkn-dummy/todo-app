//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by Ersen Tekin on 28/09/2019.
//  Copyright © 2019 Ersen Tekin. All rights reserved.
//

import UIKit

final class TodoListViewController: UITableViewController, TodoListPresenterDelegate {

    var presenter: TodoListPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        let addNavigationButton = UIBarButtonItem(barButtonSystemItem: .add,
                                                  target: self, action: #selector(didTapAddButton))

        self.navigationItem.setRightBarButton(addNavigationButton, animated: true)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        self.presenter.fetchItems()
    }

    @objc func didTapAddButton() {
        let view = self.presenter.provideAddView()
        present(view, animated: true)
    }

    // MARK: TableView methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Todo"
        } else {
            return "Done"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return presenter.todoItems.count
        } else {
            return presenter.doneItems.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellId = "CellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        guard let item = findItem(for: indexPath) else {
            return UITableViewCell(style: .default, reuseIdentifier: cellId)
        }

        cell.textLabel?.text = item.text
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = findItem(for: indexPath) else {
            return
        }

        presenter.toggleItem(item: item)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        guard let item = findItem(for: indexPath) else {
            return
        }

        if editingStyle == .delete {
            presenter.deleteItem(item: item)
        }
    }

    // MARK: PresenterDelegate

    func didFinishFetchItems() {
        self.tableView.reloadData()
    }

    func didFinishUpdate() {
        self.presenter.fetchItems()
    }

    // MARK: Private

    private func findItem(for indexPath: IndexPath) -> TodoItem? {
        switch indexPath.section {
        case 0:
            return presenter.todoItems[indexPath.row]
        case 1:
            return presenter.doneItems[indexPath.row]
        default:
            return nil
        }
    }
}
