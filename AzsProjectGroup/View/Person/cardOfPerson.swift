//
//  cardOfPerson.swift
//  AzsProject
//
//  Created by geka231 on 12.06.2023.
//

import SwiftUI

struct cardOfPerson: View {
    
    var title: String

    
    var body: some View {
        ZStack {
            Image(systemName: "person")
                .resizable()
                .padding(20)
                .frame(maxWidth: 100, maxHeight: 100)
                .background(Color(.green)).cornerRadius(100)
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
        }
    }
}


