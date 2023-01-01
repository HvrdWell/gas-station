//
//  PromoView.swift
//  AzsTabBar
//
//  Created by geka231 on 26.12.2022.
//

import SwiftUI

struct PromoView: View {
let trendingPromo : Card
    var body: some View {
        VStack {
            Image(trendingPromo.image)
                .resizable()
                .frame(width: 350, height: 155)
            
            HStack {
                Text(trendingPromo.title)
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .bold()
                    .padding(.all, /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            
            HStack {
                Text(trendingPromo.descrip)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .padding(.leading, 7)
            }
                Spacer()
        }
        .background(Color(red: 0.934, green: 0.934, blue: 0.934))
        .frame(width: 350, height: 260)
        .cornerRadius(10)
        
        
        
    }
}

struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        PromoView(trendingPromo: promoCards[0])
    }
}
