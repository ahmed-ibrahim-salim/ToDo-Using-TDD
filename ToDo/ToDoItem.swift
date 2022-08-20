//
//  ToDoItem.swift
//  ToDo
//
//  Created by Ahmad medo on 20/08/2022.
//

import Foundation

struct ToDoItem{
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?

    init(title: String, itemDescription: String? = nil, timestamp: Double? = nil,location:Location? = nil){
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}

