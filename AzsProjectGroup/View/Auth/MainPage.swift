//
//  MainPage.swift
//  AzsProject
//
//  Created by geka231 on 08.05.2023.
//

import SwiftUI

struct MainPage: View {
    
    
    var body: some View {
        VStack {
        Text("Main Page!")
            Spacer()
            Button(action: {

            }, label: {
                BigButton(titleText: "Sign Out")
            })
        }.padding(.all, 50)
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

