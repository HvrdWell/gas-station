//
//  SelectColumn.swift
//  AzsProject
//
//  Created by geka231 on 09.04.2023.
//

import SwiftUI

struct SelectColumn: View {
    var body: some View {
        NavigationView {
            VStack{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        Attendant
                        Columns
                        Columns
                        Columns
                        Columns
                    }.padding(.leading, 40)
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
        ZStack{
            Rectangle().foregroundColor(Color("sliderGradientSecond")).frame(width: 65, height: 130).cornerRadius(20)
            VStack(spacing: 6){
                Text("1").bold().font(.largeTitle)
                VStack(spacing: 2){
                    Text("92")
                    Text("95")
                    Text("95")
                    Text("ДТ")
                }.font(.caption)
            }.frame(width: 65, height: 130)
            
        }
    }
}
