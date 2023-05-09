//
//  ProgressStepper.swift
//  AzsProject
//
//  Created by geka231 on 08.05.2023.
//

import SwiftUI

struct ProgressStepper: View {
    
    @State var range: ClosedRange<Int>
    @State var fill: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geo in
            RoundedRectangle(cornerRadius: 4)
                .frame(height: 8)
                .foregroundColor(.blue)
            RoundedRectangle(cornerRadius: 4)
                .frame(width: geo.size.width * (CGFloat(fill)/CGFloat(range.upperBound)), height: 8, alignment: .leading)
                .foregroundColor(.blue)
            }
        }
    }
}

struct ProgressStepper_Previews: PreviewProvider {
    static var previews: some View {
        ProgressStepper(range: 0...5, fill: 1)
    }
}
