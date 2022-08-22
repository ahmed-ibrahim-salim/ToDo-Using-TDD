//
//  ItemManagerTests.swift
//  ToDoTests
//
//  Created by Ahmad medo on 20/08/2022.
//

import XCTest
@testable import ToDo

class ItemManagerTests: XCTestCase {
    var sut: ItemManager!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class
        sut = ItemManager()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test_ToDoCount_Initially_IsZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }
    func test_DoneCount_Initially_IsZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    func test_AddItem_IncreasesToDoCountToOne() {
        sut.add(ToDoItem(title: ""))
        XCTAssertEqual(sut.toDoCount, 1)
    }
    func test_ItemAt_ReturnsAddedItem(){
        let item = ToDoItem(title: "mega")
        
        sut.add(item)
        
        let returnedItem = sut.toDoItem(at: 0)
        XCTAssertEqual(returnedItem.title, item.title)
    }
    func test_CheckItemAt_ChangesCounts() {
        sut.add(ToDoItem(title: ""))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.doneCount, 1)
        XCTAssertEqual(sut.toDoCount, 0)
    }
    func test_checkItem_RemovesItFromToDoItems(){
        let first = ToDoItem(title: "First")
        let second = ToDoItem(title: "Second")
        
        sut.add(first)
        sut.add(second)
        
        sut.checkItem(at: 0)
        XCTAssertEqual(sut.toDoItem(at: 0).title, "Second")
    }
    func test_DoneItemAt_ReturnsCheckedItem(){
        let item = ToDoItem(title: "mega")
        sut.add(item)
        
        sut.checkItem(at: 0)
        let returnedItem = sut.doneItem(at: 0)
        
        XCTAssertEqual(returnedItem.title, item.title)
    }
    func test_EqualItems_AreEqual(){
        let item1 = ToDoItem(title: "mega")
        let item2 = ToDoItem(title: "mega")
        
        XCTAssertEqual(item1, item2)
    }
    func test_Items_WhenLocationDiffers_AreNotEqual(){
        let item1 = ToDoItem(title: "mega",location: Location(name: "Foo"))
        let item2 = ToDoItem(title: "mega",location: Location(name: "Foo"))
        XCTAssertEqual(item1, item2)
    }
    func test_RemoveAll_ResultsInCountsBeZero(){
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Bar")
        
        sut.add(first)
        sut.add(second)
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 1)
        XCTAssertEqual(sut.doneCount, 1)
        
        sut.removeAll()
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 0)
    }
    func test_Add_WhenItemsIsAlreadyAdded_DoesNotIncreaseCount(){
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Foo")
        
        sut.add(first)
        sut.add(second)
        
        XCTAssertEqual(sut.toDoCount, 1)
    }
    func test_UnCheckItem_ItemUnchecked(){
        let first = ToDoItem(title: "First")
        let second = ToDoItem(title: "Second")
        
        sut.add(first)
        sut.add(second)
        sut.checkItem(at: 0)
        sut.checkItem(at: 0)
        
        sut.uncheckItem(at: 1)
        
        XCTAssertEqual(second, sut.toDoItem(at: 0))
        
    }
}
