//
//  OrderView.swift
//  AzsProject
//
//  Created by geka231 on 17.05.2023.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject private var vm: LocationViewModel
    @EnvironmentObject private var ovm: OrderViewModel
    @StateObject private var viewModel = QrCodeViewModel()
    @State private var showError = false
    @State private var isEmailValid = false
     @State private var errorMessage = ""
    @State private var ErrorMessageTitle = ""
    @State var comments = [Comments]()
    @State var totalPrice: Float
    @State var liters: Float
    @State private var points: Int = 0
    @State private var Email: String = ""
    let column: Column
    let nameTypeFuel: String
    let price: Float
    var TotalPriceForOrder: Float {
            return totalPrice - Float(points)
}

    
    var body: some View {
        NavigationView {
            VStack {
                Text(nameTypeFuel)
                    .font(.title)
                    .bold()
            Text("Колонка "+"\(column.columnNumber)")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("Ваш заказ")
                    .font(.title3)
                    .bold()
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                HStack{
                    Text("Топливо")
                    Spacer()
                    Text("Литров")
                    Spacer()
                    Text("руб/л")
                }.padding(.horizontal)
                Divider()
                HStack{
                    Text(nameTypeFuel)
                    Spacer()
                    Text(String(format: "%.2f", liters) + "")
                    Spacer()
                    Text(String(format: "%.2f", price) + "")
                }.padding()
                Divider()
                VStack{
                    VStack{
                        HStack{
                                Text("У вас баллов: \(viewModel.scoresCard)")
                            Spacer()
                        }.padding(.horizontal)
                            .padding(.bottom)
                        HStack{
                            Text("Итого без баллов: ")
                            Text(String(format: "%.2f", totalPrice) + " ₽").bold()
                            Spacer()
                        }.padding(.horizontal)
                        HStack{
                            if let scoresCard = Int(viewModel.scoresCard) {
                                Stepper(value: $points, in: 0...min(scoresCard, Int(totalPrice))) {
                                    Text("Баллов: \(points)")
                                }
                            } else {
                                Text("Проблемы с бонусной системой")
                            }
                            }.padding(.horizontal)
                        Divider()
                    HStack{
                        Text("ИТОГО: " + String(format: "%.2f", TotalPriceForOrder) + "₽").bold()
                    Spacer()
                    }.padding(.horizontal)
                    }
                    HStack{
                        Text("Почта для чека: ").bold()
                        TextField("Почта для чека", text: $Email)
                            .onChange(of: Email, perform: { value in
                                isEmailValid = validateEmailFormat(email: value)
                            })
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(isEmailValid ? .clear : .red)
                                    .padding(.top, 8)
                                    .padding(.horizontal, -4)
                                    .offset(y: 8)
                                , alignment: .bottom
                            )
                    }.padding(.horizontal)
                    }
                VStack{
                    Button {
                        let userId = UserDefaults.standard.integer(forKey: Constants.UserIDKey)

                        let order = OrderDTO(
                            nameTypeFuel: nameTypeFuel,
                            idColumns: column.columnNumber,
                            idUser: userId,
                            totalCountFuel: liters,
                            totalPrice: TotalPriceForOrder,
                            scores: points,
                            email: Email
                        )
                        
                        APIManagerOrder.shared.createOrder(order: order) { result in
                                DispatchQueue.main.async {
                                    switch result {
                                    case .success:
                                        errorMessage = "Успешно"
                                        ErrorMessageTitle = "Сообщение"
                                        showError = true
                                    case .failure(let error):
                                        showError = true
                                        ErrorMessageTitle = "Ошибка"
                                        errorMessage = "На данной станции не хватает топлива"
                                    }
                                }
                            }
                        } label: {
                        Circle()
                            .foregroundColor(Color("sliderButtonPay"))
                            .opacity(isEmailValid == false ? 0.1 : 1.0)
                            .frame(width: 65, height: 65)
                    }

                    Text("Оплатить").font(.title3)
                }.padding()
                    .disabled(Email.isEmpty || !isEmailValid)
                }.ignoresSafeArea()
                .alert(isPresented: $showError) {
                    Alert(
                        title: Text(ErrorMessageTitle),
                        message: Text(errorMessage),
                        dismissButton: .default(Text("OK")) {
                            showError = false
                            vm.sheetLocation = nil
                        }
                    )}
        }.ignoresSafeArea()
        .onAppear {
                viewModel.createCardAndVerifyToken()
            }
        }
    
    func validateEmailFormat(email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }
    
    }



