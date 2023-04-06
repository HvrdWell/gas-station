//
//  PersonCard.swift
//  AzsProject
//
//  Created by geka231 on 21.03.2023.
//

import SwiftUI

struct PersonCard: View {
    var body: some View {
        ZStack {
            VStack {
                ZStack{
                    Image(systemName: "person") 
                        .resizable()
                }.padding(30)
                    .frame(maxWidth: 200, maxHeight: 200)
                    .background(Color("ourGreen")).cornerRadius(100)
                    .overlay(Circle().stroke(Color.black, lineWidth: 5))
            }
        }
    }
}

struct PersonCard_Previews: PreviewProvider {
    static var previews: some View {
        PersonCard()
    }
}
