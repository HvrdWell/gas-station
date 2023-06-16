//
//  QrCodeView.swift
//  AzsProject
//
//  Created by geka231 on 02.01.2023.
//

import SwiftUI

struct QrCodeView: View {
    @StateObject private var viewModel = QrCodeViewModel()
    @State private var isAnimationPlaying = true

    var body: some View {
            VStack() {
                VStack(){
                    Text("Для обновления")
                    Text("Нажмите внутрь круга")
                }.font(.boldTwelve)
                Button {
                    viewModel.createCardAndVerifyToken()
                    isAnimationPlaying = true 
                } label: {
                    ZStack{
                        LottieView(animation: "CarAround")
                                                .onAppear {
                                                    if isAnimationPlaying {
                                                        viewModel.createCardAndVerifyToken()
                                                    }
                                                }
                                                .onDisappear {
                                                    isAnimationPlaying = false
                                                }
                        VStack{
                            Text("\(viewModel.scoresCard)").bold()
                            Text("бонусов")
                                .bold()
                        }
                    }.frame(width: 250, height: 250)
                }

                Image(uiImage: UIImage(data: viewModel.generateQR(text: viewModel.numberOfQR)!)!)
                    .resizable()
                    .frame(width: 250, height: 250)

                VStack(spacing: 5){
                    Text("Покажите QR-код кассиру")
                    Text("для начисления бонусов")
                }.font(.boldTwelve)
            }.background()
            .ignoresSafeArea()
            
        .onAppear {
            viewModel.createCardAndVerifyToken()
        }
    }
}

struct QrCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeView()

    }
}

