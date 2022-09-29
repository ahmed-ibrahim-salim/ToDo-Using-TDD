//
//  ToDoItem.swift
//  ToDo
//
//  Created by Ahmad medo on 20/08/2022.
//

import Foundation

struct ToDoItem: Equatable{

    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    var plistDict: [String:Any]{
        return [:]
    }
    init?(dict: [String : Any]){
        return nil
    }
    init(title: String, itemDescription: String? = nil, timestamp: Double? = nil,location:Location? = nil){
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }

//    func makeItemFromPlist()->ToDoItem?{
//        let dict = self.plistDict
//        return ToDoItem(title: dict["title"] as! String)
//    }
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        if lhs.location != rhs.location{
            return false
        }
        if lhs.timestamp != rhs.timestamp{
            return false
        }
        if lhs.itemDescription != rhs.itemDescription{
            return false
        }
        if lhs.title != rhs.title{
            return false
        }
        return true
    }
}

