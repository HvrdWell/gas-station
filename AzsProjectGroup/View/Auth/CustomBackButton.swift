//
//  CustomBackButton.swift
//  AzsProject
//
//  Created by geka231 on 08.05.2023.
//

import SwiftUI

struct CustomBackButton: View {
    
    let buttonTap: () -> Void
    var color: Color?
    
    var body: some View {
        Button(action: {
            buttonTap()
        }, label: {
            Image.backArrow
                .resizable()
                .renderingMode(color != nil ? .template : .original)
                .foregroundColor(color)
                .scaledToFit()
                .frame(width: 24, height: 24, alignment: .center)
        })
    }
    
}

struct CustomBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackButton(buttonTap: { print("Button Tapped") })
    }
}
