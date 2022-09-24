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
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
        sut = vc as? ItemListViewController
        addButton = sut.navigationItem.rightBarButtonItem
        action = addButton.action
        UIApplication.shared.keyWindow?.rootViewController = sut

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
             sut.presentedViewController as! InputViewController
        XCTAssertNotNil(inputViewController.titleTextField)
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
}


