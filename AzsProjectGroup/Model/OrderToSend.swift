//
//  OrderToSend.swift
//  AzsProject
//
//  Created by geka231 on 18.05.2023.
//

import Foundation

struct OrderToSend: Codable {
    let IdColumns: Int
    let IdUser: Int
    let totalCountFuel: Float
    let totalPrice: Float
    let Scores: Int
}

