//
//  LocationViewModel.swift
//  AzsTabBar
//
//  Created by geka231 on 25.12.2022.
//

import Foundation
import MapKit
import SwiftUI

class LocationViewModel: ObservableObject {
    //all loaded locations
    @Published var locations: [Location]
    @State var ActiveView: Int = 1
    //Current location on map
    @Published var mapLocation: Location{
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    //current region on map
    @Published var mapRegion:MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    //show list of locations
    @Published var showLocationsList: Bool = false
    
    //Show location detail via sheet
    @Published var sheetLocation: Location? = nil
    @Published var sheetFuelLocation: Location? = nil
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
    func openFuelingView( ) {
        sheetFuelLocation = sheetLocation
        sheetLocation = nil
    }
    func CurrentView(page: Int)   {
        ActiveView = page
    }
    func toggleLocationsList(){
        withAnimation(.easeInOut){
            showLocationsList.toggle()
        }
    }
    func showNextLocation(Location: Location) {
        withAnimation(.easeInOut){
            mapLocation = Location
            showLocationsList = false
        }
    }

    
    func nextButtonPressed( ){
       
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current location in location array! Should be happen.")
            return
        }
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            //Next index is not valid
            //restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(Location:  firstLocation)
            return
        }
        
        //Next index IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(Location: nextLocation)
    }
}
