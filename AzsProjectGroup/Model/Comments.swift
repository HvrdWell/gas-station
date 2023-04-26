//
//  Comments.swift
//  jsonCheck
//
//  Created by geka231 on 24.04.2023.
//

import Foundation
import SwiftUI

struct Comments: Codable, Identifiable, Hashable {
    let id = UUID()
    let nameTypeFuel: String
    let price: Float

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: Comments, rhs: Comments) -> Bool {
        return lhs.id == rhs.id
    }
}
