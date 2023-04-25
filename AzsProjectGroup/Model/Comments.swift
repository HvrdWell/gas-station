//
//  Comments.swift
//  jsonCheck
//
//  Created by geka231 on 24.04.2023.
//

import Foundation
import SwiftUI

struct Comments: Codable, Identifiable {
    let id = UUID()
    let nameTypeFuel: String
    let price: Float
    
}
