//
//  BaseView.swift
//  AzsTabBar
//
//  Created by geka231 on 19.12.2022.
//

import SwiftUI

struct BaseView: View {
    @StateObject var baseData = BaseViewModel( )
    init(){
        
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        TabView(selection: $baseData.currentTab){
            Text("home")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.04) )
                .tag(Tab.Home)
                
            Text("trends")
                .tag(Tab.trends)
            Text("locat")
                .tag(Tab.locat)
            Text("person")
                .tag(Tab.Person)
        }
        .overlay(
            HStack(spacing:  0){
                TabButton(Tab: .Home)
                TabButton(Tab: .trends)
                    .offset(x: -10)
                
                Button {
                    print("213")
                } label: {
                    Image("QR")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 26,height: 26)
                        .foregroundColor(.white)
                        .offset(x: -1)
                        .padding(18)
                        .background(Color(hue: 0.61, saturation: 0.206, brightness: 0.179))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                }
                .offset(y: -22)

                
                TabButton(Tab: .locat)
                    .offset(x: 10)
                TabButton(Tab: .Person)
            }
                .background(
                    Color.white
                        .clipShape(CustomCurveShape())
                        .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                        .ignoresSafeArea(.container, edges: .bottom)
                )
            
            ,alignment: .bottom
        )
    }
    @ViewBuilder
    func TabButton(Tab: Tab)-> some View{
        Button {
            withAnimation{
                baseData.currentTab = Tab
            }
        } label: {
            Image(Tab.rawValue)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(baseData.currentTab == Tab ? Color (.black) : Color.gray.opacity(0.5))
                .frame(maxWidth: .infinity)
        }

    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
