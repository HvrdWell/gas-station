//
//  locationDetailView.swift
//  AzsProject
//
//  Created by geka231 on 07.04.2023.
//

import SwiftUI
import MapKit
struct locationDetailView: View {
    
    @EnvironmentObject private var vm: LocationViewModel
    let location: Location
    
    var body: some View {
        ScrollView{
            VStack{
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0 , y: 10)
                
                VStack(alignment: .leading, spacing: 16){
                    titleSection
                    gasoline
                    Divider( )



                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
    }
}

struct locationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        locationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationViewModel( ))
    }
}

extension locationDetailView{
    private var imageSection: some View{
        TabView {
//            ForEach(location.imageNames, id: \.self){
            Image("gasST")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil  : UIScreen.main.bounds.width)
                    .clipped()
//            }
        }
        .frame(height: 200)
        .tabViewStyle(PageTabViewStyle())
    }
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.callout)
                .foregroundColor(.secondary)
        }
    }
    private var gasoline: some View{
        HStack{
            ForEach(location.idTypeFuel, id: \.self){
                let Id = $0
                HStack{
          
                    Text(location.nameTypeFuel[Id].components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
                        .font(.callout)
                        .foregroundColor(.secondary)
                    Text("\(String(format: "%.2f",location.price[Id]))")
                        .font(.callout)
                        .foregroundColor(.black)
                }.padding(5).border(.opacity(10)).foregroundColor(Color(location.nameTypeFuel[Id]))
            }
        }
    }
    private var cells: some View {
        HStack{
            Rectangle()
        }
    }
  

    private var backButton: some View{
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}


