//
//  RefuelingSlider.swift
//  AzsProject
//
//  Created by geka231 on 08.04.2023.
//

import SwiftUI



struct RefuelingSlider: View {
    private let sendOrderToApi = SendOrderToApi()
    
    @EnvironmentObject private var vm: LocationViewModel
    @EnvironmentObject private var ovm: OrderViewModel
    @State var comments = [Comments]()
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    @State var totalPrice: Float = 0.0
    @State var liters: Float = 0.0
    let column: Column
    let nameTypeFuel: String
    let price: Float
    //Slider propert
    @State var sliderProgress: CGFloat = 0
    @State var sliderHeight: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    var body: some View{
        VStack(spacing: 50){
            VStack{
                    Text(nameTypeFuel)
                        .font(.title)
                        .bold()
                Text("Колонка "+"\(column.columnNumber)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                HStack{
                    Text(String(format: "%.2f", totalPrice) + "₽")
                        .font(.title3)
                        .bold()
                    Slider
                    Text(String(format: "%.2f", liters) + "л")
                        .font(.title3)
                        .bold()
                        .padding(5)
                }
                PayButton
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("bg").ignoresSafeArea())
            .preferredColorScheme(.light)
        }
    }

extension RefuelingSlider{
    private var PayButton: some View{
        VStack{
            Button {
                guard let columnNumber = Int(column.columnNumber) else {
                                    // Handle invalid input or display an error message
                                    return
                                }
                let order = OrderData(orderId: 7, idColumns: columnNumber, idUser: 4,
                                      status: "Выполнен"  ,totalPrice: 600)
                sendOrderToApi.sendOrderToAPI(order)
            } label: {
                Circle().foregroundColor(Color("sliderButtonPay")).frame(width: 65, height: 65)
            }
            Text("Оплатить").font(.title3)
        }
    }
    private var Slider: some View{
        VStack{
            ZStack(alignment: .top){
                Text("Максимум")
                    .font(.caption)
                    .foregroundColor(sliderHeight == maxHeight ? .black : .gray )
                ZStack{
                    ZStack(alignment: .bottom, content:  {
                        
                        Rectangle( )
                            .fill(Color("slider1").opacity(0.15))
                        
                        Rectangle( )
                            .fill(sliderHeight == maxHeight ?
                                  LinearGradient(gradient: Gradient(colors: [Color("sliderGradientSecond"), Color("sliderGradientFirst"),]), startPoint: .top, endPoint: .bottom):
                                    LinearGradient(colors: [Color("slider")], startPoint: .top, endPoint: .leading)
                            )
                            .frame(height: sliderHeight)
                    })
                    .frame(width: 150, height: maxHeight+20, alignment: .center)
                    .cornerRadius(35)
                    .overlay(
                        
                        Text("\(Int(sliderProgress * 100))%")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 18)
                            .cornerRadius(10)
                            .padding(.vertical, 30)
                            .offset(y:  sliderHeight < maxHeight - 205 ? -sliderHeight : -maxHeight + 205)
                        
                        ,alignment: .bottom
                    )
                    .gesture(DragGesture(minimumDistance: 0).onChanged({  (value) in
                        
                        let traslation = value.translation
                        
                        sliderHeight = -traslation.height + lastDragValue
                        
                        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                        
                        sliderHeight = sliderHeight >= 15 ? sliderHeight : 15
                        
                        let progress = sliderHeight / maxHeight
                        
                        sliderProgress = progress <= 1.0 ? progress : 1
                    }).onEnded({ (value) in
                        
                        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                        
                        sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                        
                        lastDragValue = sliderHeight
                        
                        
                    }))
                }
            } .onChange(of: sliderProgress) { _ in

                totalPrice = price * Float(Int(sliderProgress * 100))
                liters = totalPrice / price
            }
        }
    }
}
