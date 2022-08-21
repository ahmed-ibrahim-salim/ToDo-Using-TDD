//
//  Location.swift
//  ToDoTests
//
//  Created by Ahmad medo on 20/08/2022.
//

import XCTest
import CoreLocation

@testable import ToDo

class LocationTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test_Init_WhenGivenCoordinate_SetsCoordinate(){
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "",coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    func test_Init_WhenGivenName_SetsName() {
        let location = Location(name: "Foo")
        XCTAssertEqual(location.name, "Foo")
    }
    func test_EqualLocations_AreEqual(){
        let location1 = Location(name: "Foo")
        let location2 = Location(name: "Foo")
        XCTAssertEqual(location1, location2)
    }
    func test_Location_WhenLatitudeDiffers_AreNotEqual(){
        assertLocationNotEqualWith(firstName: "Foo", firstLongLat: (1.0,0.0), secondName: "Foo", secondLongLat: (0.0,0.0))
    }
    func test_Location_WhenLongitudeDiffers_AreNotEqual(){
        let firstCoordinate =
        CLLocationCoordinate2D(latitude: 0.0,
                               longitude: 1.0)
        let first = Location(name: "Foo",
                             coordinate: firstCoordinate)
        let secondCoordinate =
        CLLocationCoordinate2D(latitude: 0.0,
                               longitude: 0.0)
        let second = Location(name: "Foo",
                              coordinate: secondCoordinate)
        XCTAssertNotEqual(first, second)
    }
    func test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual() {
        assertLocationNotEqualWith(firstName: "Foo",
                                   firstLongLat: (0.0, 0.0),
                                   secondName: "Foo",
                                   secondLongLat: nil)
    }
    func test_Locations_WhenNamesDiffer_AreNotEqual() {
        assertLocationNotEqualWith(firstName: "Foo",
                                   firstLongLat: nil,
                                   secondName: "Bar",
                                   secondLongLat: nil)
    }
    func assertLocationNotEqualWith(firstName: String, firstLongLat:(Double,Double)?, secondName: String, secondLongLat:(Double,Double)?, line:UInt = #line){
        var firstCoord: CLLocationCoordinate2D? = nil
        if let firstLongLat = firstLongLat {
            firstCoord =
            CLLocationCoordinate2D(latitude: firstLongLat.0,
                                   longitude: firstLongLat.1)
        }
        let firstLocation =
        Location(name: firstName,
                 coordinate: firstCoord)
        var secondCoord: CLLocationCoordinate2D? = nil
        if let secondLongLat = secondLongLat {
            secondCoord =
            CLLocationCoordinate2D(latitude: secondLongLat.0,
                                   longitude: secondLongLat.1)
        }
        let secondLocation =
        Location(name: secondName,
                 coordinate: secondCoord)
        XCTAssertNotEqual(firstLocation, secondLocation,line: line)
    }
}
