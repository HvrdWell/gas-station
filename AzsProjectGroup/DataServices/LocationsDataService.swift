//
//  LocationsDataService.swift
//  AzsTabBar
//
//  Created by geka231 on 25.12.2022.
//

import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            name: "АЗС 29",
            cityName: "Г.Москва, проспект мира, вл.  186Б",
            coordinates: CLLocationCoordinate2D(latitude: 55.753544, longitude: 37.621202),
            description: "Red Square is one of the oldest and largest squares in Moscow, the capital of Russia. Owing to its historical significance and the adjacent historical buildings, it is regarded as one of the most famous squares in Europe and the world.",
            idTypeFuel: [0,1],
            nameTypeFuel: [
                          "АИ-92",
                          "АИ-95"
                          ],
            price: [54.44 , 56.54],
            imageNames: [
                "moscow-redsquare1",
                "moscow-redsquare2"
            ],
            link: "https://en.wikipedia.org/wiki/Red_Square"),
        Location(
            name: "PavukVasya",
            cityName: "Moscow",
            coordinates: CLLocationCoordinate2D(latitude: 55.861141, longitude: 37.590973),
            description: "The House of PavukVasya",
            idTypeFuel: [0,1],
            nameTypeFuel: [
                "АИ-92",
                "АИ-95"
                          ],
            price: [54.44 , 56.54],
            imageNames: [
                "moscow-pavukhome1",
            ],
            link: "https://en.wikipedia.org/wiki/PavukVasya"),
        
    ]
    
}
