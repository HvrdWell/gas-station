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

    var body: some View {
        mapLayer.ignoresSafeArea()
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
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations, annotationContent: { location in
            //MapMarker(coordinate: location.coordinates, tint: .blue) Это вывод сининий воскл знак на карту
            MapAnnotation(coordinate: location.coordinates){
                //Text("Hello") Вместо меток будет хелло
                LocationMapAnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(Location: location)
                    }
            }
        })
    }
}
