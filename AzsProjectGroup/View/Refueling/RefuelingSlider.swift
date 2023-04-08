//
//  RefuelingSlider.swift
//  AzsProject
//
//  Created by geka231 on 08.04.2023.
//

import SwiftUI

struct RefuelingSlider_Previews: PreviewProvider {
    static var previews: some View {
        RefuelingSlider()
    }
}

struct RefuelingSlider: View {
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    
    //Slider propert
    @State var sliderProgress: CGFloat = 0
    @State var sliderHeight: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    var body: some View{
        VStack(spacing: 50){
            VStack{
                    Text("АИ-95")
                        .font(.title)
                        .bold()
                    Text("Колонка "+"1")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("1360"+"₽")
                        .font(.title3)
                        .bold()
                    Slider
                    Text("26"+"Л")
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
                print("das")
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
                            .offset(y:  sliderHeight < maxHeight - 105 ? -sliderHeight : -maxHeight + 105)
                        
                        ,alignment: .bottom
                    )
                    .gesture(DragGesture(minimumDistance: 0).onChanged({  (value) in
                        
                        let traslation = value.translation
                        
                        sliderHeight = -traslation.height + lastDragValue
                        
                        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                        
                        sliderHeight = sliderHeight >= 20 ? sliderHeight : 20
                        
                        let progress = sliderHeight / maxHeight
                        
                        sliderProgress = progress <= 1.0 ? progress : 1
                    }).onEnded({ (value) in
                        
                        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                        
                        sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                        
                        lastDragValue = sliderHeight
                        
                        
                    }))
                }
            }
        }
    }
}
