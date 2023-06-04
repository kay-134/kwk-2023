//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Kayley Chery on 6/3/23.
//

import Foundation

class ToDoItem: Identifiable {
    var id = UUID()
    
    var title = ""
    var isImportant = false
    
    init(title: String, isImportant: Bool = false) {
            self.title = title
            self.isImportant = isImportant
        }
}
