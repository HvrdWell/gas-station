//
//  Location.swift
//  AzsTabBar
//
//  Created by geka231 on 25.12.2022.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {

    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let idTypeFuel: [Int]
    let nameTypeFuel: [String]
    let price: [Float]
    let imageNames: [String]
    let link: String
    
    

    var id: String{
        name + cityName
    }
    

    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}

