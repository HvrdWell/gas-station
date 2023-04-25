//
//  Fuel.swift
//  jsonCheck
//
//  Created by geka231 on 24.04.2023.
//

import Foundation

struct Column: Decodable {
    let columnNumber: String
    let typeFuels: [Fuel]
}

struct Fuel: Decodable {
    let idTypeFuel: Int
    let nameTypeFuel: String
    let price: Float
    let storages: [Storage]
}

struct Storage: Decodable {
}

