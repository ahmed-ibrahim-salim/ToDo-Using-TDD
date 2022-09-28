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
    var mockNavigatinController: MockNavigationController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:
                                                        "ItemListViewController")
        sut = vc as? ItemListViewController
        mockNavigatinController = MockNavigationController(rootViewController: sut)
        addButton = sut.navigationItem.rightBarButtonItem
        action = addButton.action
        UIApplication.shared.keyWindow?.rootViewController = mockNavigatinController

        sut.loadViewIfNeeded()
    }
    override func tearDownWithError() throws {
        sut = nil
        addButton = nil
        action = nil
    }
    
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
    
    func testItemListVC_ReloadTableViewWhenAddNewTodoItem_IncreaseRowsCount() {
        // given
        guard let addButton = sut.navigationItem.rightBarButtonItem else{
            XCTFail()
            return
        }
        guard let action = addButton.action else{
            XCTFail()
            return
        }
        
        // when
        sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
        
        guard let inputViewController = sut.presentedViewController as? InputViewController else{
            XCTFail()
            return
        }
        inputViewController.titleTextField.text = "Test Title"
        inputViewController.save()
        sut.tableView.reloadData()
        
        // then
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    func testItemSelectedNotification_PushesDetailVC(){
        sut.itemManager?.add(ToDoItem(title: "foo"))
        sut.itemManager?.add(ToDoItem(title: "bar"))
        
        NotificationCenter.default.post(name: NSNotification.Name("ItemSelectedNotification"), object: nil, userInfo: ["index": 1])
        guard let detailViewController = mockNavigatinController.lastPushedViewController as? DetailViewController else {
            return XCTFail()
        }
        guard let detailItemManager = detailViewController.itemInfo?.0 else {
            return XCTFail()
        }
        guard let index = detailViewController.itemInfo?.1 else {
            return XCTFail()
        }
        detailViewController.loadViewIfNeeded()
        XCTAssertTrue(detailItemManager === sut.itemManager)
        XCTAssertNotNil(detailViewController.titleLabel)
        XCTAssertEqual(index, 1)
    }
}

extension ItemListViewControllerTest{
    class MockNavigationController: UINavigationController{
        var lastPushedViewController: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            
            lastPushedViewController = viewController
            super.pushViewController(viewController, animated: animated)
        }
        
        
    }
}
