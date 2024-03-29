//
//  MapPage.swift
//  AzsTabBar
//
//  Created by geka231 on 25.12.2022.
//

import SwiftUI
import MapKit
struct MapPage: View {
    @EnvironmentObject private var vm: LocationViewModel
    @StateObject private var locationManager = LocationManager ( )
    
    var region: Binding<MKCoordinateRegion>? {
        guard let location = locationManager.location else {
            return MKCoordinateRegion.defaulPos().getBinding()
        }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        return region.getBinding( )
    }
    var body: some View {
        ZStack{
            mapLayer
                .ignoresSafeArea( )
        }.sheet(item: $vm.sheetLocation, onDismiss: {
            vm.sheetLocation = nil 
        }) { location in
            locationDetailView(location: location)
                .presentationDetents(vm.ActiveView == 1 ? [.large] : [.large])
        }

    }
}

struct MapPage_Previews: PreviewProvider {
    static var previews: some View {
        MapPage()
            .environmentObject(LocationViewModel())
    }
}

extension MapPage{
    private var mapLayer: some View{
        Map(coordinateRegion: $vm.mapRegion, showsUserLocation: true, annotationItems: vm.locations, annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates){
                LocationMapAnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(Location: location)
                        vm.sheetLocation = location
                    }
            }
        })
    }
}
