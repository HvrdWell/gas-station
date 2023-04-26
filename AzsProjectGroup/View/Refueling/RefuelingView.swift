//
//  RefuelingView.swift
//  AzsProject
//
//  Created by geka231 on 08.04.2023.
//

import SwiftUI

struct RefuelingView: View {
    @EnvironmentObject private var vm: LocationViewModel
    @EnvironmentObject private var ovm: OrderViewModel
    @State var comments = [Comments]()
    let column: Column
    var body: some View {
        VStack{
            Text("Колонка \(column.columnNumber)").font(.title2).bold()
            Text("MosOil").foregroundColor(.green).font(.caption)
            List(comments, id: \.self) { comment in
                NavigationLink(destination: RefuelingSlider(column: column, nameTypeFuel: comment.nameTypeFuel, price: comment.price)) {
                    VStack(alignment: .leading) {
                        HStack{
                            Text(comment.nameTypeFuel)
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Spacer()
                            Text(String(format: "%.2f", comment.price) + "₽")
                                .font(.body)
                        }
                    }
                }
            }
            .onAppear() {
                if let columnNumber = Int(column.columnNumber) {
                    apiCall(numberofcolumn: columnNumber).getUserComments { comments,error in
                        if let comments = comments{
                            self.comments = comments
                        }else if let error = error{
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            .navigationTitle("Title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Spacer()
                        Spacer()
                    }
                }
            }
        }
    }
}

