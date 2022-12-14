//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by Ahmad medo on 20/08/2022.
//

import XCTest

@testable import ToDo

class ToDoItemTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_Init_WhenGivenTitle_SetsTitle() {
        let item = ToDoItem(title: "Foo")
        XCTAssertEqual(item.title, "Foo")
    }
    func test_Init_WhenGivenDescription_SetsDescription() {
        let item = ToDoItem(title: "",
                            itemDescription: "Bar")
        XCTAssertEqual(item.itemDescription, "Bar")
    }
    func test_Init_WhenGivenTimestamp_SetsTimestamp(){
        let item = ToDoItem(title: "", itemDescription: "",timestamp: 0.2)
        XCTAssertEqual(item.timestamp, 0.2)
        
    }
    func test_Init_WhenGivenLocation_SetsLocation(){
        let location = Location(name: "Foo")
        let item = ToDoItem(title:"Bar",location:location)
        
        XCTAssertEqual(item.location?.name, location.name)
    }
    func test_Items_WhenOneLocationIsNil_AreNotEqual(){
        var first = ToDoItem(title: "",
                             location: Location(name: "Foo"))
        var second = ToDoItem(title: "",
                              location: nil)
        first = ToDoItem(title: "",
                         location: nil)
        second = ToDoItem(title: "",
                          location: Location(name: "Foo"))
        
        XCTAssertNotEqual(first, second)
    }
    func test_Items_WhenTimestampsIDiffer_AreNotEqual(){
        let first = ToDoItem(title: "",timestamp: 0.1)
        let second = ToDoItem(title: "",timestamp: 0.2)
        
        XCTAssertNotEqual(first, second)
    }
    func test_Items_WhenItemsDescriptionsDiffer_AreNotEqual(){
        let first = ToDoItem(title: "",itemDescription: "")
        let second = ToDoItem(title: "",itemDescription: "none")
        
        XCTAssertNotEqual(first, second)
    }
    func test_Items_WhenTitlesDiffer_AreNotEqual() {
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Bar")
        XCTAssertNotEqual(first, second)
    }
    func test_HasPlistDictionaryProperty(){
        let item = ToDoItem(title: "Foo")
        let dictionary = item.plistDict
        XCTAssertNotNil(dictionary)
        XCTAssertTrue(dictionary is [String:Any])
    }
    func test_CanBeCreatedFromPlistDictionary(){
        let location = Location(name: "Bar")
        let item = ToDoItem(title: "Foo",
                                 itemDescription: "Baz",
                                 timestamp: 1.0,
                                 location: location)
        
        let dictionary = item.plistDict
        
        let recreatedItem = ToDoItem(dict: dictionary)
        XCTAssertEqual(item, recreatedItem)
    }
}
