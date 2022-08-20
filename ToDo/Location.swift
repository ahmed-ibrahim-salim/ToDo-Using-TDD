//
//  Location.swift
//  ToDo
//
//  Created by Ahmad medo on 20/08/2022.
//

import Foundation
import CoreLocation

struct Location{
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil){
        self.name = name
        self.coordinate = coordinate
    }
}
