//
//  HomeView.swift
//  AzsProject
//
//  Created by geka231 on 10.04.2023.
//

import SwiftUI

struct HomeView: View {
    
    @State var currentIndex: Int = 0
    @State var showDetailView: Bool = false
    @State var currentDetailProduct: Product?
    @StateObject private var viewModel = QrCodeViewModel()
    @Namespace var animation
    let userData : userModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15){
                HeaderView()
                SearchView()
                ProductView()
            }
            .padding(15)
            .padding(.bottom, 50)
        }
        .overlay {
            if let currentDetailProduct, showDetailView{
                DetailView(showView: $showDetailView, animation: animation, product: currentDetailProduct)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(x: 0.1)))
            }
        }
        .onAppear {
                viewModel.createCardAndVerifyToken()
            }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack{
            VStack(alignment: .leading, spacing: 3){
                Text("Здравствуйте,")
                    .font(.title)
                Text("\(viewModel.userName) " + "🔥")
                    .font(.title.bold( ) )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            ZStack{
                HStack{
                    Text("\(viewModel.scoresCard)").bold()
                    Image("coins")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
            }
            .padding(2)
            .padding(.horizontal, 5)
            .background(Color("GoldenBonus"))
            .cornerRadius(10)
                
                
        }
    }
    
    @ViewBuilder
    func SearchView( )->some View{
        HStack(spacing: 15) {
            HStack(spacing: 15) {
                Image(systemName: "cart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                Divider()
                TextField("Наша продукция", text: .constant(""))
            }
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .fill(.white)
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
                    

                }
                .padding(.leading,5)
                
                CustomCarousel(index: $currentIndex, items: Products, id: \.id) { Product, size in
                    ProductCardView(product: Product, size: size)
                        .contentShape(Rectangle( ))
                        .onTapGesture {
                            hideTabBarFunc()
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)){
                                currentDetailProduct = Product
                                showDetailView = true
                            }
                        }
                }
                .frame(height: 380)
                .padding(.top,20)
                .padding(.horizontal,10)
        }
            .padding(.top, 22)
    }
    @ViewBuilder
    func ProductCardView(product: Product, size: CGSize ) -> some View{
        ZStack{
            LinearGradient(colors: [Color("slider"),Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            VStack{
                Button {
                    print("432")
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.title3)
                        .foregroundColor(Color.green)
                        .frame(width: 50, height: 50)
                        .background {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(.white)
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(15)
                VStack{
                   if currentDetailProduct?.id == product.id && showDetailView{
                        Rectangle( )
                            .fill(.clear)
                    }else{
                        Image(product.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: product.id, in: animation)
                            .padding(.bottom, -35)
                            .padding(.top, -40)
                    }
                }.zIndex(1)
                HStack{
                    VStack(alignment: .leading, spacing: 7) {
                        Text(product.name)
                            .font(.callout)
                            .fontWeight(.bold)
                        
                        Text(product.price)
                            .font(.title3)
                            .fontWeight(.black)
                    }
                    .lineLimit(1)
                    .frame(maxWidth: .infinity,alignment: .leading )
                    Button {
                        print("321")
                    } label: {

                    }

                }
                .padding([.horizontal, .top], 15)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.white)
                }
                .padding(10)
                .zIndex(0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userData:  userModel())
    }
}
