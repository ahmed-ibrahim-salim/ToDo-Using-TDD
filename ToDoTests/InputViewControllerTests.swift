//
//  InputViewControllerTests.swift
//  ToDoTests
//
//  Created by magdy khalifa on 25/08/2022.
//

import XCTest
import CoreLocation

@testable import ToDo

class InputViewControllerTests: XCTestCase {
    var sut: InputViewController!
    var placemark: MockPlacemark!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard
            .instantiateViewController(
                withIdentifier: "InputViewController")
        as? InputViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {}
    
    func test_HasTitleTextField(){
        
        let hasTitleTextField = sut.titleTextField.isDescendant(of: sut.view)
        XCTAssertTrue(hasTitleTextField)
    }
    func test_HasDateTextField(){
        let hasDateTextField = sut.dateTextField.isDescendant(of: sut.view)
        XCTAssertTrue(hasDateTextField)
    }
    func test_HasLocationTextField(){
        let hasLocationTextField = sut.locationTextField.isDescendant(of: sut.view)
        XCTAssertTrue(hasLocationTextField)
    }
    func test_HasAddressTextField(){
        let hasAddressTextField = sut.addressTextField.isDescendant(of: sut.view)
        XCTAssertTrue(hasAddressTextField)
    }
    func test_HasDescriptionTextField(){
        let hasDescriptionTextField = sut.descriptionTextField.isDescendant(of: sut.view)
        XCTAssertTrue(hasDescriptionTextField)
    }
    func test_HasSaveButton(){
        let hasSaveButton = sut.saveButton.isDescendant(of: sut.view)
        XCTAssertTrue(hasSaveButton)
    }
    func test_HasCancelButton(){
        let hasCancelButton = sut.cancelButton.isDescendant(of: sut.view)
        XCTAssertTrue(hasCancelButton)
    }
    func test_Save_UsesGeocoderToGetCoordinateFromAddress(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let timestamp = 1456095600.0
        let date = Date(timeIntervalSince1970: timestamp)
        
        sut.titleTextField.text = "Foo"
        sut.dateTextField.text = dateFormatter.string(from: date)
        sut.locationTextField.text = "Bar"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Baz"
        
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.itemManager = ItemManager()
        
        sut.save()
        
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2DMake(37.3316851, -122.0300674)
        
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let item = sut.itemManager?.toDoItem(at: 0)
        
        let testItem = ToDoItem(title: "Foo",
            itemDescription: "Baz",
            timestamp: timestamp,
            location: Location(name: "Bar",coordinate:coordinate))

        XCTAssertEqual(item, testItem)
    }
}

extension InputViewControllerTests {
    
     class MockGeocoder: CLGeocoder {
       
         var completionHandler: CLGeocodeCompletionHandler?
       
         override func geocodeAddressString(_ addressString: String,
         completionHandler: @escaping CLGeocodeCompletionHandler) {
         self.completionHandler = completionHandler
       }
         
    }
    
    class MockPlacemark: CLPlacemark{
        
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation? {
            guard let mockCoordinate = mockCoordinate else {
                return CLLocation()
            }
            return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
        }
    }
    
}
