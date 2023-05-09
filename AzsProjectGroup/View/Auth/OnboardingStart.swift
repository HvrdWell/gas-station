//
//  OnboardingStart.swift
//  AzsProject
//
//  Created by geka231 on 08.05.2023.
//

import SwiftUI

struct OnboardingStart: View {

    let appName = "MosOIL"
    let buttonSpacing: CGFloat = 10
    @EnvironmentObject var viewRouter: ViewRouter
    @State var errorStr: String? = nil
    @State var nextPage: Bool = false
    @Environment(\.window) var window: UIWindow?
    
    var body: some View {
        VStack {
            Image.appIcon
                .resizable()
                .frame(width: 70, height: 70, alignment: .center)
                .padding(.top, 100)
            Text("Здравствуйте")
                .font(.medTwentyEight)
                .foregroundColor(.space)
            Text(appName)
                .font(.medTwentyEight)
                .foregroundColor(.slateBlue)
            Spacer()
            VStack(spacing: buttonSpacing) {
                NavigationLink(
                    destination: OnboardingPhoneEntry().environmentObject(viewRouter),
                    isActive: $nextPage,
                    label: {
                        BigButton(titleText: "Войти через телефон")
                    }
                )
                    .padding(.bottom, 50)
            }.frame(width: 250)
        }.overlay(errorView)
    }
    
    var errorView: some View {
        VStack {
            if let err = errorStr {
                HStack {
                    Image.warning
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.slateBlue)
                        .frame(width: 18, height: 18)
                    Text(err)
                        .font(.regTwelve)
                }
            }
            Spacer()
        }
    }
    


    
 
    
    
    }

    

struct OnboardingStart_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStart()
    }
}

