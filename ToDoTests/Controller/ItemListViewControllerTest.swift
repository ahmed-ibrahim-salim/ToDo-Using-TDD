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
    var addButton: UIBarButtonItem!
    var action: Selector!
    var mockTableView: MocktableView!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = storyboard.instantiateInitialViewController() as! UINavigationController
        UIApplication.shared.keyWindow?.rootViewController = nav
        
        sut = nav.topViewController as? ItemListViewController
        mockTableView = MocktableView()
        sut.tableView = mockTableView
        
        addButton = sut.navigationItem.rightBarButtonItem
        action = addButton.action
        
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
    func test_ItemListViewController_HasAddBarButtonWithSelfAsTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? UIViewController, sut)
    }
    func test_AddItem_PresentsAddItemViewController() {
        XCTAssertNil(sut.presentedViewController)
        sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
        
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is InputViewController)
        let inputViewController =
             sut.presentedViewController as? InputViewController
        XCTAssertNotNil(inputViewController?.titleTextField)
    }
    func testItemListVC_SharesItemManagerWithInputVC() {
        sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
        guard let inputViewController = sut.presentedViewController as? InputViewController else{
            XCTFail()
            return
        }
        guard let inputItemManager = inputViewController.itemManager else{
            XCTFail()
            return
        }
        XCTAssertTrue(inputItemManager === sut.itemManager)
    }
    func test_ViewDidLoad_SetsItemManagerToDataProvider() {
        XCTAssertTrue(sut.itemManager === sut.dataProvider.itemManager)
    }
    
    func testItemListVC_ReloadTableViewWhenAddNewTodoItem() {
        
        guard let addButton = sut.navigationItem.rightBarButtonItem else{
            XCTFail()
            return
        }
        
        guard let action = addButton.action else{
            XCTFail()
            return
        }
//
        sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
        
        guard let inputViewController = sut.presentedViewController as? InputViewController else{
            XCTFail()
            return
        }
//
        inputViewController.titleTextField.text = "Test Title"
        inputViewController.save()

        XCTAssertTrue(mockTableView.calledReloadData)
    }
}

extension ItemListViewControllerTest{
    
    class MocktableView: UITableView{
        
        var calledReloadData: Bool = false
        
        override func reloadData() {
            calledReloadData = true
            super.reloadData()

        }
        
    }
}
