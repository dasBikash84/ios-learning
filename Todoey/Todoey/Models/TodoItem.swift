//
//  TodoItem.swift
//  Todoey
//
//  Created by bikash on 30/5/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct TodoItem {
    var name : String
    var checked : Bool
}

struct TodoItems {
    var items:[TodoItem] = []
}
