//
//  StoryboardTests.swift
//  ToDoTests
//
//  Created by Ahmad medo on 24/09/2022.
//

import XCTest
@testable import ToDo

class StoryboardTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {    }
    
    func test_InitialViewController_IsItemListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController =
        storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationController.viewControllers[0]
        XCTAssertTrue(rootViewController is ItemListViewController)
    }
    
}
