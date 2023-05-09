//
//  AzsTabBarApp.swift
//  AzsTabBar
//
//  Created by geka231 on 19.12.2022.
//

import SwiftUI
@main
struct AzsTabBarApp: App {
    @ObservedObject var viewRouter: ViewRouter
    
    init() {
        self.viewRouter = ViewRouter()

        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        
    }

    var body: some Scene {
        WindowGroup {
            if viewRouter.currentView == .main {
                BaseView().environmentObject(viewRouter)
            } else {
                NavigationView {
                    switch viewRouter.currentView {
                    case .onboarding, .accountSetup:
                        OnboardingStart().environmentObject(viewRouter)
                    case .main:
                        BaseView()
                    }
                }
            }
        }
    }
}
