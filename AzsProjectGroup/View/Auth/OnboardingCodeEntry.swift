//
//  OnboardingCodeEntry.swift
//  AzsProject
//
//  Created by geka231 on 08.05.2023.
//

import SwiftUI

struct OnboardingCodeEntry: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: OnboardingEntryViewModel
    @EnvironmentObject var viewRouter: ViewRouter

    
    var body: some View {
            VStack(spacing: 30) {
                if viewModel.visibleError != nil { errorView }
                Spacer(minLength: 100)
            headerView
                CodeEntry(code: $viewModel.code)
                
                Spacer()
                Button(action: {
                    viewModel.resendCode()
                }, label: {
                    Text("Отправить код повторно")
                        .font(.medFourteen)
                        .foregroundColor(.slateBlue)
                })
                Button(action: {
                   viewModel.verifyCode()
                    if viewModel.isCodeValid {
                        self.viewRouter.login()
                    }
                }, label: {
                BigButton(titleText: "Войти")
                    .padding(.bottom, 50)
                    .frame(width: 250)
                })
                }.padding([.leading, .trailing], 50)
            .navigationBarBackButtonHidden(true)
           .navigationBarItems(leading: CustomBackButton(buttonTap: backBtnTapped))
            .background(viewBackground)
    }
    
    var headerView: some View {
        VStack(spacing: 15) {
            Text("Шаг 2/2")
                .font(.medTwelve)
                .foregroundColor(.darkMustard)
                .tracking(1.5)
            
            Text("Подтвердите ваш номер")
                .font(.medTwentyFour)
                .foregroundColor(.space)
                .multilineTextAlignment(.center)
            VStack(spacing: 8){
                Text("Мы отправили код на")
                Text("\(viewModel.selectedCode!+viewModel.phoneNum)")
                    .font(.regSixteen)
                    .foregroundColor(.navy)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                ProgressStepper(range: 0...2, fill: 2)
                    .frame(width: 120)
            }
        }
    }
    
    var phoneNumEntry: some View {
        Rectangle()
        //PhoneNumEntryView(viewModel: viewModel)
    }
    
    var errorView: some View {
        HStack {
            Spacer()
            Image.warning
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.slateBlue)
                .frame(width: 18, height: 18, alignment: .center)
            Text(viewModel.visibleError?.localizedDescription ?? "")
                .font(.medTwelve)
            Spacer()
        }
        
    }
    
    func backBtnTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct OnboardingCodeEntry_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCodeEntry(viewModel: OnboardingEntryViewModel(viewRouter: ViewRouter()))
    }
}

