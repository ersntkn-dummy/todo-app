//
//  MockPresenterDelegate.swift
//  TodoAppTests
//
//  Created by Ersen Tekin on 01/10/2019.
//  Copyright © 2019 Ersen Tekin. All rights reserved.
//

import Foundation
@testable import TodoApp

final class MockPresenterDelegate: TodoListPresenterDelegate {
    var calledDidFinishFetchItems = false
    var calledDidFinishUpdate = false

    func didFinishFetchItems() {
        calledDidFinishFetchItems = true
    }

    func didFinishUpdate() {
        calledDidFinishUpdate = true
    }
}
