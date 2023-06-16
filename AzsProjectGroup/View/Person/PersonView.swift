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
                ScrollView{
                VStack{
                    NavigationLink(destination: EditUser()) {
                        HStack(spacing: 20) {
                            cardOfPerson(title: "321").frame(width: 60, height: 60)
                                
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Ваше имя").bold().font(.title)
                                Text("Мои данные").fontWeight(.light).font(.callout).foregroundColor(.gray)
                            }
                        }
                    }

                    Button {
                        viewRouter.logout()
                    } label: {
                        Text("Выйти")
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .foregroundColor(.black)
                            .font(.system(.title, design: .rounded))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }.padding(.top, 430)
                }.padding(20)
            }
                .navigationBarHidden(false)
                    .navigationTitle("Личный кабинет")
                    .navigationBarTitleDisplayMode(.large)
                    .font(.system(.title,design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
        }
 
            
        }
    }


struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
