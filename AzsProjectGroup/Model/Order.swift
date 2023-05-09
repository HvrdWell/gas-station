//
//  Order.swift
//  AzsProject
//
//  Created by geka231 on 25.04.2023.
//

import Foundation

struct OrderData: Codable {
    let orderId: Int
    let idColumns: Int
    let idUser: Int
    let status: String
    let totalPrice: Float
}

