//
//  Order.swift
//  AzsProject
//
//  Created by geka231 on 25.04.2023.
//

import Foundation

struct OrderDTO: Codable {
    let nameTypeFuel: String
    let idColumns: Int
    let idUser: Int
    let totalCountFuel: Float
    let totalPrice: Float
    let scores: Int
    let email: String
}


