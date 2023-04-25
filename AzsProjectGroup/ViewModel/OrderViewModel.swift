//
//  OrderViewModel.swift
//  AzsProject
//
//  Created by geka231 on 25.04.2023.
//

import Foundation

class OrderViewModel: ObservableObject {
    
    @Published var idColumn: Int? = nil
    @Published var totalPrice: Float? = nil
    
    init(idColumn: Int? = nil) {
        self.idColumn = idColumn

    }
}
