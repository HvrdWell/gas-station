//
//  LocationManager.swift
//  AzsProject
//
//  Created by geka231 on 06.04.2023.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

final class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    private var locationManager = CLLocationManager( )
    
    override init() {
        super .init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.location = location
        }
    }
}
extension MKCoordinateRegion  {
    static func defaulPos( ) -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.755826, longitude: 37.6173),
                                                       span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
    }
    func getBinding( ) -> Binding<MKCoordinateRegion>? {
        return Binding<MKCoordinateRegion>(.constant(self))
    }
}
