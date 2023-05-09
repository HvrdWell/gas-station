//
//  ContentView.swift
//  AzsTabBar
//
//  Created by geka231 on 19.12.2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    
    var body: some View {
        if isLoggedIn {
            BaseView()
        } else {
            OnboardingStart()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
