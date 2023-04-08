//
//  LocationMapAnotationView.swift
//  AzsTabBar
//
//  Created by geka231 on 24.12.2022.
//

import SwiftUI

struct LocationMapAnotationView: View {
    let accentColor = Color("AccentColor")
    var body: some View {
        VStack(spacing: 0){
            Image("mLogoMapp")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.green)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

struct LocationMapAnotationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            LocationMapAnotationView()
        }
    }
}
