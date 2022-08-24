//
//  DetailViewControllerTests.swift
//  ToDoTests
//
//  Created by magdy khalifa on 22/08/2022.
//

import XCTest
import CoreLocation

@testable import ToDo

class DetailViewControllerTests: XCTestCase {
    var sut: DetailViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard
            .instantiateViewController(
                withIdentifier: "DetailViewController")
        as? DetailViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {}
    
    
    func test_HasTitleLabel(){
        let titleLabelIsSubView = sut.titleLabel.isDescendant(of: sut.view)
        XCTAssertTrue(titleLabelIsSubView)
    }
    func test_HasDateLabel(){
        let dateLabelIsSubView = sut.titleLabel.isDescendant(of: sut.view)
        XCTAssertTrue(dateLabelIsSubView)
    }
    func test_HasLocationLabel(){
        let locationLabelIsSubView = sut.titleLabel.isDescendant(of: sut.view)
        XCTAssertTrue(locationLabelIsSubView)
    }
    func test_HasDescriptionLabel(){
        let descriptionLabelIsSubView = sut.titleLabel.isDescendant(of: sut.view)
        XCTAssertTrue(descriptionLabelIsSubView)
    }
    func test_HasMapView(){
        let mapViewIsSubView = sut.mapView.isDescendant(of: sut.view)
        XCTAssertTrue(mapViewIsSubView)
    }
    func test_SettingItemInfo_SetsTextsToLabels(){
        let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)
        let location = Location(name: "Foo", coordinate: coordinate)
        let item = ToDoItem(title: "Bar",
                            itemDescription: "Baz",
                            timestamp: 1456150025,
                            location: location)
        let itemManager = ItemManager()
        itemManager.add(item)
        
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(sut.titleLabel.text, "Bar")
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
        XCTAssertEqual(sut.locationLabel.text, "Foo")
        XCTAssertEqual(sut.descriptionLabel.text, "Baz")
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude,
                       coordinate.latitude,
                       accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude,
                       coordinate.longitude,
                       accuracy: 0.001)
    }
}
