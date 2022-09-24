//
//  ItemManager.swift
//  ToDo
//
//  Created by Ahmad medo on 20/08/2022.
//

import Foundation

class ItemManager: NSObject{
    
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []
    
    
    func add(_ toDoItem: ToDoItem){
        
        if !toDoItems.contains(toDoItem){
            toDoItems.append(toDoItem)
        }
    }
    func item(at index:Int)->ToDoItem{
        return toDoItems[index]
    }
    func toDoItem(at index: Int)-> ToDoItem{
        return toDoItems[index]
    }
    func doneItem(at index: Int)-> ToDoItem{
        return doneItems[index]
    }
    func checkItem(at index: Int){
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
    func uncheckItem(at index: Int) {
         let item = doneItems.remove(at: index)
         toDoItems.append(item)
    }
    func removeAll(){
        toDoItems.removeAll()
        doneItems.removeAll()
    }
}
