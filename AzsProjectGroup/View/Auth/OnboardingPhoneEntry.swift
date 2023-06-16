//
//  OnboardingPhoneEntry.swift
//  AzsProject
//
//  Created by geka231 on 08.05.2023.
//

import SwiftUI

struct OnboardingPhoneEntry: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: OnboardingEntryViewModel = OnboardingEntryViewModel(viewRouter: ViewRouter())
    
    var body: some View {
        VStack(spacing: 30) {
            if viewModel.visibleError != nil { errorView }
            Spacer(minLength: 100)
            headerView
            PhoneNumEntryView(viewModel: viewModel)
            
            Spacer()
            
            BigButton(titleText: "Получить код")
                .padding(.bottom, 50)
                .frame(width: 250)
                .onTapGesture {
                    viewModel.sendTextCode()
                }
            NavigationLink(
                destination: OnboardingCodeEntry(viewModel: viewModel).environmentObject(viewRouter),
                isActive: $viewModel.nextPage,
                label: {  })
        }.padding([.leading, .trailing], 50)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(buttonTap: backBtnTapped))
        .background(viewBackground)


    }
    
    var headerView: some View {
        VStack(spacing: 15) {
            Text("Шаг 1/2")
                .font(.medTwelve)
                .foregroundColor(.darkMustard)
                .tracking(1.5)
                .shadow(color: .white, radius: 2, x: 0.0, y: 0.0)
                
            
            Text("Давайте войдем в личный кабинет")
                .font(.medTwentyFour)
                .foregroundColor(.space)
                .multilineTextAlignment(.center)
            
            Text("Номер по которому вы можете войти")
                .font(.regSixteen)
                .foregroundColor(.navy)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                ProgressStepper(range: 0...2, fill: 1)
                    .frame(width: 120)
            }
        }
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

struct PhoneNumEntry_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPhoneEntry( )
    }
}

