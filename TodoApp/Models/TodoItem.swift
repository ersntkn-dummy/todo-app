//
//  TodoItem.swift
//  TodoApp
//
//  Created by Ersen Tekin on 28/09/2019.
//  Copyright © 2019 Ersen Tekin. All rights reserved.
//

import RealmSwift

final class TodoItem: Object {
    @objc dynamic var identifier: String = UUID().uuidString
    @objc dynamic var text: String = ""
    @objc dynamic var isDone: Bool = false

    override static func primaryKey() -> String? {
        return "identifier"
    }
}
