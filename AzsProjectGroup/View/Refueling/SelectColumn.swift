//
//  SelectColumn.swift
//  AzsProject
//
//  Created by geka231 on 09.04.2023.
//

import SwiftUI

struct SelectColumn: View {
    let apiManager = APIManager()
    @State var columns: [Column] = []
    @EnvironmentObject private var ovm: OrderViewModel
    let column: Column? = nil
    var body: some View {
        NavigationView {
                VStack{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            Attendant
                            NavigationViewForFuels
                        }.foregroundColor(.black)
                    }.padding(.leading, 40)
                }
                .onAppear {
                    apiManager.getColumns { columns, error in
                        DispatchQueue.main.async {
                            if let columns = columns {
                                self.columns = columns
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }

            }
    }
}

struct SelectColumn_Previews: PreviewProvider {
    static var previews: some View {
        SelectColumn()
    }
}
extension SelectColumn{
    private var NavigationViewForFuels: some View{
        ForEach(columns, id: \.columnNumber) { column in
            NavigationLink(destination: RefuelingView(column: column)) {
                    ZStack{
                        Rectangle().foregroundColor(Color("sliderGradientSecond")).frame(width: 65, height: 130).cornerRadius(20)
                        VStack(spacing: 6){
                            Text(column.columnNumber).bold().font(.largeTitle)
                            VStack(spacing: 2){
                                ForEach(column.typeFuels, id: \.idTypeFuel) { fuel in
                                    Text(fuel.nameTypeFuel)
                                }
                            }.font(.caption)
                        }.frame(width: 65, height: 130)
                    }
                }.foregroundColor(.black)
        }
    }
    private var Attendant: some View{
        ZStack{
            VStack{
                Image("refueller").resizable()
                    .frame(width: 50, height: 50).padding(.bottom, 20)
                
                Text("Заправщик здесь").bold().font(.caption).multilineTextAlignment(.center)
                
            }
        }.frame(width: 90, height: 130).overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 0.6)
        }
    }
    private var Columns: some View{
        ForEach(columns, id: \.columnNumber) { column in
            ZStack{
                Rectangle().foregroundColor(Color("sliderGradientSecond")).frame(width: 65, height: 130).cornerRadius(20)
                VStack(spacing: 6){
                    Text(column.columnNumber).bold().font(.largeTitle)
                    VStack(spacing: 2){
                        ForEach(column.typeFuels, id: \.idTypeFuel) { fuel in
                            Text(fuel.nameTypeFuel)
                        }
                    }.font(.caption)
                }.frame(width: 65, height: 130)
            }
        }
    }
}
