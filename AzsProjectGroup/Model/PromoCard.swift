//
//  PromoCard.swift
//  AzsProject
//
//  Created by geka231 on 14.06.2023.
//

import Foundation
import UIKit
import SwiftUI

struct Promocard: Identifiable, Decodable {
    let id: Int
    let image: String
    let title: String
    let description: String
    let dateOfStart: Date
    let dateOfEnd: Date
}






