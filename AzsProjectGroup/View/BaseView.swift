//
//  BaseView.swift
//  AzsTabBar
//
//  Created by geka231 on 19.12.2022.
//

import SwiftUI

struct BaseView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @StateObject private var vm = LocationViewModel()
    @StateObject var baseData = BaseViewModel( )
    @State private var showSheet = false
    @State var showTabBar: Bool = true
    
    init(){
        UITabBar.appearance().isHidden = showTabBar
    }
    
    var body: some View {
        TabViewExt
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

extension BaseView{
    private var TabViewExt: some View{
        
        TabView(selection: $baseData.currentTab){
            HomeView( userData: userModel())
                .tag(Tab.Home)
                
            TrendView()
                .tag(Tab.trends)
            MapPage() .environmentObject(vm)
                .tag(Tab.locat)
            PersonView()
                .tag(Tab.Person)

        }
        .onReceive(NotificationCenter.default.publisher(for: .init("SHOWTABBAR"))){ _ in
            showTabBar = true
        }
        .onReceive(NotificationCenter.default.publisher(for: .init("HIDETABBAR"))){ _ in
            showTabBar = false
        }
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: showTabBar)
        
        .overlay(
            Group{
                if showTabBar {
                    HStack(spacing:  0){
                        TabButton(Tab: .Home)
                        TabButton(Tab: .trends)
                            .offset(x: -10)
                        
                        QrButton
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
                }
            }.animation(.easeInOut, value: 0.2)
            ,alignment: .bottom
        )
        
    }
    private var QrButton: some View{
        Button {
            showSheet.toggle()
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
        }.offset(y: -22)
            .sheet(isPresented: $showSheet, content: {
            QrCodeView() .environmentObject(LocationViewModel())
        })
    }
}

extension View{
    func showTabBarFunc( ) {
        NotificationCenter.default.post(name: NSNotification.Name("SHOWTABBAR"), object: nil)
    }
    func hideTabBarFunc( ) {
        NotificationCenter.default.post(name: NSNotification.Name("HIDETABBAR"), object: nil)
    }
}
