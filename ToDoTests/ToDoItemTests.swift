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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
}
