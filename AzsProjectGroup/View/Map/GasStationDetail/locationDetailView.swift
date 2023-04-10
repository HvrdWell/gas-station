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
    @State private var isTaped = false
    let location: Location
    
    var body: some View {
        NavigationView {
            
            
            ScrollView{
                VStack{
                    imageSection
                        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0 , y: 10)
                    
                    VStack(alignment: .leading, spacing: 16){
                        titleSection
                        gasoline
                        Divider( )
                        cells
                        
                        Divider( )
                        services
                        CallToUs
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
            Image("gasST")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil  : UIScreen.main.bounds.width)
                    .clipped()
        }
        .frame(height: 200)
        .tabViewStyle(PageTabViewStyle())
    }
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 8){
            HStack( ){
                Text(location.name)
                    .font(.largeTitle)
                .fontWeight(.semibold)
                Spacer()
                Image(systemName: isTaped ? "heart.fill" : "heart")
                    .onTapGesture{
                        isTaped.toggle()
                    }
            }
            Text(location.cityName)
                .font(.callout)
                .foregroundColor(.secondary)
        }
    }
    private var gasoline: some View{
        ScrollView(.horizontal, showsIndicators: false){
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
                    }.padding(5)
                        .border(.opacity(10))
                        .foregroundColor(Color(location.nameTypeFuel[Id]))
                }
            }
        }
    }
    private var cells: some View {
        HStack(alignment: .center){
            NavigationLink(destination: RefuelingSlider ( )) {
                
                Text("Заправиться")
                    .foregroundColor(.white)
                    .padding(15)
                    .padding(.horizontal, 100)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.075, green: 0.108, blue: 0.184)/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
            }
            
        }.frame(maxWidth: .infinity)
            
    }
    @ViewBuilder func getView(viewImageName: String, ViewName: String) -> some View {
        HStack (alignment: .center){
                   VStack(spacing: 5){
                       Image(systemName: viewImageName).foregroundColor(.green).font(.system(size: 25))
                       Text(ViewName).font(.title3)
                   }
               }.frame(maxWidth: .infinity)
        .padding(20)
                   .padding(.horizontal,27)
                   .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 1.0, green: 1.0, blue: 1.0)/*@END_MENU_TOKEN@*/)
                   .cornerRadius(20)
                   .shadow(color: .black, radius: 0.001)
                   
    }
    private var services: some View{
        VStack(alignment: .leading){
            HStack( ){
                Text("Услуги")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            VStack{
                HStack{
                    getView(viewImageName: "cart.fill", ViewName: "Магазин")
                    getView(viewImageName: "figure.dress.line.vertical.figure", ViewName: "Туалет")
                }
                HStack{
                    getView(viewImageName: "mug.fill", ViewName: "Кафе")
                    getView(viewImageName: "car.2.fill", ViewName: "Паркинг")
                }
            }
        }
    }
    private var CallToUs: some View{
        HStack{
            Button {
                
                if let phoneCallURL = URL(string: "tel://\(01234567)"), UIApplication.shared.canOpenURL(phoneCallURL)
                {
                    UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
                }
             
            } label: {
                Image(systemName: "phone.circle").foregroundColor(.green).font(.system(size: 50))
            }

            VStack(alignment: .leading,spacing: 10){
                Text("Позвоните на АЗС").font(.title3).bold()
                Text("Позвоните нам по любым вопросам").font(.callout)
            }.padding(.leading, 40)
        } .padding(18).padding(.leading, 20) .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 1.0, green: 1.0, blue: 1.0)/*@END_MENU_TOKEN@*/) .padding(.horizontal, 10)
            .cornerRadius(30)
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


