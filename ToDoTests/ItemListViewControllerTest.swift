//
//  ItemListViewControllerTest.swift
//  ToDoTests
//
//  Created by Ahmad medo on 21/08/2022.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTest: XCTestCase {
    var sut: ItemListViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
        sut = vc as? ItemListViewController
        
        sut.loadViewIfNeeded()
        
    }
    override func tearDownWithError() throws {}
    
    func test_TableView_AfterViewDidLoad_IsNotNil(){
        
        XCTAssertNotNil(sut.tableView)
    }
    func test_LoadingView_SetsTableViewDataSource() {
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
    }
    func test_LoadingView_SetsTableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
    }
    func test_LoadingView_DataSourceEqualDelegate() {
        XCTAssertEqual(sut.tableView.dataSource as? ItemListDataProvider,
                       sut.tableView.delegate as? ItemListDataProvider)
    }
}
