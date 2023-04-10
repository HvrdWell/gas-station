//
//  Products.swift
//  AzsProject
//
//  Created by geka231 on 10.04.2023.
//

import SwiftUI

struct Product: Identifiable,Equatable {
    var id: String = UUID( ).uuidString
    var image: String
    var name: String
    var price: String
}

var Products: [Product] = [
    Product(image: "cheese-burger", name: "Картошка Ангус", price: "70₽"),
    Product(image: "cheese-burger", name: "Стейк с кукурузой", price:" 150₽"),
    Product(image: "cheese-burger", name: "Ролл Цезарь", price: "175₽"),
    Product(image: "cheese-burger", name: "Салат Клоу-Слоу", price: "200₽")



]
