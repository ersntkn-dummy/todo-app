//
//  TodoListPresenterTests.swift
//  TodoAppTests
//
//  Created by Ersen Tekin on 29/09/2019.
//  Copyright © 2019 Ersen Tekin. All rights reserved.
//

import XCTest
@testable import TodoApp

class TodoListPresenterTests: XCTestCase {

    var presenter: TodoListPresenter!
    var mockDatabaseManager: MockDatabaseManager!
// swiftlint:disable:next weak_delegate
    var mockDelegate: MockPresenterDelegate!

    override func setUp() {
        super.setUp()
        mockDatabaseManager = MockDatabaseManager()
        mockDelegate = MockPresenterDelegate()
        presenter = TodoListPresenter(databaseManager: mockDatabaseManager)
        presenter.delegate = mockDelegate
    }

    func testFetchItems() {
        XCTAssertFalse(mockDelegate.calledDidFinishFetchItems)
        XCTAssertFalse(mockDatabaseManager.calledFetchTodoItems)

        presenter.fetchItems()

        XCTAssertTrue(mockDelegate.calledDidFinishFetchItems)
        XCTAssertTrue(mockDatabaseManager.calledFetchTodoItems)

        XCTAssertEqual(presenter.todoItems.count, 1)
        XCTAssertEqual(presenter.doneItems.count, 0)
        XCTAssertEqual(presenter.todoItems.first?.text, MockDatabaseManager.fetchedItemText)
    }

    func testDeleteItem() {
        XCTAssertFalse(mockDelegate.calledDidFinishUpdate)
        XCTAssertNil(mockDatabaseManager.deletedItem)

        let dummyItem = TodoItem(value: [ "text": "any", "isDone": false ])
        presenter.deleteItem(item: dummyItem)

        XCTAssertTrue(mockDelegate.calledDidFinishUpdate)
        XCTAssertEqual(mockDatabaseManager.deletedItem, dummyItem)
    }

    func testAddItem() {
        XCTAssertFalse(mockDelegate.calledDidFinishUpdate)
        XCTAssertNil(mockDatabaseManager.addedItem)

        let text = "aText"
        presenter.addItem(text: text)

        XCTAssertTrue(mockDelegate.calledDidFinishUpdate)
        XCTAssertEqual(mockDatabaseManager.addedItem?.text, text)
    }

    func testToggleItem() {

        XCTAssertFalse(mockDelegate.calledDidFinishUpdate)
        XCTAssertFalse(mockDatabaseManager.calledUpdateItem)

        let dummyItem = TodoItem(value: [ "text": "any", "isDone": true ])
        presenter.toggleItem(item: dummyItem)

        XCTAssertTrue(mockDelegate.calledDidFinishUpdate)
        XCTAssertTrue(mockDatabaseManager.calledUpdateItem)
    }

    func testProvideAddView() {
        let view = presenter.provideAddView()

        guard let alertView = view as? UIAlertController else {
            XCTFail("view type should be UIAlertController")
            return
        }

        XCTAssertEqual(alertView.actions.count, 1)
        XCTAssertEqual(alertView.title, "New item")
    }
}
