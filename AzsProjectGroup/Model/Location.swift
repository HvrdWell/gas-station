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
    
    
    //Identifyble
    var id: String{
        // name = "Colosseum"
        //cityName = "Rome"
        // id = "ColosseumRome"
        name + cityName
    }
    
    //Equatable!!!!!
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}

