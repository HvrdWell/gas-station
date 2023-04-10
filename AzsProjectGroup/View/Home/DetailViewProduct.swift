//
//  DetailViewProduct.swift
//  AzsProject
//
//  Created by geka231 on 10.04.2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var showView: Bool
    @State var showContent: Bool = false
    var animation: Namespace.ID
    var product: Product
    
    var body: some View {
        GeometryReader{
            let size = $0.size
        
            VStack(spacing: -30) {
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: product.id, in: animation)
                    .frame(width: size.width - 50, height: size.height / 1.6)
                    .zIndex(1)
                VStack(spacing: 20){
                    HStack{
                        Text(product.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(product.price)
                            .font(.title3.bold())
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.green.opacity(0.1))
                            }
                    }
                    .padding(.top, 25)
                }
                .padding(.top, 30)
                .padding(.bottom, 15)
                .padding(15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(content: {
                    CustomCorner(corners: [.topLeft, .topRight], radius: 25)
                        .fill(.white)
                        .ignoresSafeArea( )
                })
                .offset(y: showContent ? 0 : (size.height / 1.5))
                .zIndex(0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .padding(.top, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top, content: {
            
            HeaderView()
                .opacity(showContent ? 1 : 0)
        })
        .background{
            Rectangle( )
                .fill(Color.green.gradient)
                .ignoresSafeArea()
                .opacity(showContent ? 1 : 0)
        }
        .onAppear{
            withAnimation(.easeIn(duration: 0.35).delay(0.05)){
                showContent = true
            }
        }
    }
    @ViewBuilder
        func HeaderView() -> some View {
            Button {
                withAnimation(.easeInOut(duration: 0.3)){
                    showContent=false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                    showTabBarFunc( )
                    withAnimation(.easeInOut(duration: 0.35)){
                        showView = false
                    }
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }


struct DetailViewProduct_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
