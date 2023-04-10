//
//  HomeView.swift
//  AzsProject
//
//  Created by geka231 on 10.04.2023.
//

import SwiftUI

struct HomeView: View {
    let userData : userModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                HeaderView()
                SearchView()
                ProductView()
            }
            .padding(15)
            .padding(.bottom, 50)
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack{
            VStack(alignment: .leading, spacing: 8){
                Text("Здравствуйте 🔥")
                    .font(.title)
                Text("\(userData.name)")
                    .font(.title.bold( ) )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button{
                
            }label: {
                Image(systemName: "bell")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(17)
                    .background{
                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .fill(.white)
                    }
                    .overlay(alignment: .topTrailing) {
                        Text("1")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(6)
                            .background{
                                Circle( )
                                    .fill(Color.green)
                            }
                            .offset(x: 5, y: -10)
                    }
            }
        }
    }
    
    @ViewBuilder
    func SearchView( )->some View{
        HStack(spacing: 15) {
            HStack(spacing: 15) {
                Image("Search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                Divider()
                TextField("Поиск", text: .constant(""))
            }
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .fill(.white)
            }
            Button {
                
            } label: {
                Image("filter")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 22, height: 22)
                    .padding(15)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black)
                    }
            }
        }.padding(.top, 15)
    }
        @ViewBuilder
        func ProductView()->some View{
            VStack(alignment: .leading, spacing: 15) {
                HStack (alignment: .center, spacing: 15){
                    Image(systemName: "square.grid.2x2.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 13, height: 13)
                    
                    Text("Популярно")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button("Показать"){
                        
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                .padding(.leading,5)
        }
            .padding(.top, 22)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userData:  userModel())
    }
}
