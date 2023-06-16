//
//  OnboardingStart.swift
//  AzsProject
//
//  Created by geka231 on 08.05.2023.
//

import SwiftUI
import Lottie

struct OnboardingStart: View {

    let appName = "MosOIL"
    let buttonSpacing: CGFloat = 10
    @EnvironmentObject var viewRouter: ViewRouter
    @State var errorStr: String? = nil
    @State var nextPage: Bool = false
    @Environment(\.window) var window: UIWindow?
    
    var body: some View {
        VStack {
            Text("Здравствуйте")
                .font(.medTwentyEight)
                .foregroundColor(.space)
                .padding(.top, 100)
            Text(appName)
                .font(.medTwentyEight)
                .foregroundColor(.slateBlue)
            LottieView(animation: "carAnimation")
                .frame(width: 370, height: 350)


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

