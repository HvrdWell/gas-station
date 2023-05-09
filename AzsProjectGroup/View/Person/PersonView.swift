//
//  PersonView.swift
//  AzsProject
//
//  Created by geka231 on 21.03.2023.
//

import SwiftUI

struct PersonView: View {
    @EnvironmentObject var viewRouter: ViewRouter


    var body: some View {
        NavigationView {
            VStack {
                Button {
                    viewRouter.logout()
                } label: {
                    Text("Выйти")
                }
            }
        }
            .padding()
            .navigationBarHidden(false)
            .navigationTitle("Личный кабинет")
            .font(.system(.title, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.black)
        }
    }


struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
