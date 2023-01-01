//
//  PromoOpen.swift
//  AzsTabBar
//
//  Created by geka231 on 26.12.2022.
//

import SwiftUI

struct PromoOpen: View {
    
    @State var promo: Card
    
    
    var body: some View {
        ScrollView{
            VStack(spacing: 3){
                photoOfPromo
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0 , y: 10)
                titleOfPromo
                Divider()
                descriptionOfPromo
                
                
            }
            
            .tabViewStyle(PageTabViewStyle())
        }.ignoresSafeArea()
            .background(.ultraThinMaterial)
        
        
    }
    
    
    
}


struct PromoOpen_Previews: PreviewProvider {
    static var previews: some View {
        PromoOpen(promo: promoCards[0])
    }
}

extension PromoOpen{
    
    private var photoOfPromo: some View{
        TabView {
            Image(promo.image)
                .resizable()
                .scaledToFit()
                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil  : UIScreen.main.bounds.width)
                .clipped()
        }.ignoresSafeArea()
        .frame(height: 230)
            .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleOfPromo: some View{
        VStack(alignment: .leading){
            Text(promo.title)
                .font(.system(size: 35))
                .bold()
                .fixedSize(horizontal: false, vertical: true)
 
        }.padding(.trailing,20)
            .padding(.top)
        
    }
    
    private var descriptionOfPromo: some View{
        VStack(alignment: .leading){
            Text(promo.descrip)
                .font(.title3)
                .fixedSize(horizontal: false, vertical: true)
        }.padding()
    }
}
