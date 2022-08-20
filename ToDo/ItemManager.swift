//
//  ItemManager.swift
//  ToDo
//
//  Created by Ahmad medo on 20/08/2022.
//

import Foundation

class ItemManager{
    
    var toDoCount = 0
    var doneCount = 0
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []

    func add(_ toDoItem: ToDoItem){
        toDoCount += 1
        toDoItems.append(toDoItem)
    }
    func item(at index: Int)-> ToDoItem{
        return toDoItems[index]
    }
    func checkItem(at index: Int){
        toDoCount -= 1
        doneCount += 1
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
    func doneItem(at index: Int)-> ToDoItem{
        return doneItem(at: index)
    }
}
