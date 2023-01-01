//
//  test.swift
//  AzsProject
//
//  Created by geka231 on 27.12.2022.
//

import SwiftUI
import ScalingHeaderScrollView

struct test: View {
    
    enum Screen {
        case first, second, third
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedScreen: Screen = .first
    @State private var scrollToTop: Bool = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScalingHeaderScrollView {
                VStack(spacing: 0) {
                    Text("fds")
    
                    
                    tabBar
                }
                .frame(width: UIScreen.main.bounds.width)
            } content: {
                Image("firstNews")
                Image("firstNews")
                Image("firstNews")
                Image("firstNews")

            }
            .scrollToTop(resetScroll: $scrollToTop)
            .ignoresSafeArea()
            
            Button("", action: { self.presentationMode.wrappedValue.dismiss() })
                .padding(.leading, 16)
        }
    }
    
    // MARK: - Private
    
    private var tabBar: some View {
        ZStack {
            Color.white
            Color.gray.opacity(0.15)
            HStack {
                Spacer()
                Text("One")
                    .onTapGesture {
                        selectedScreen = .first
                        scrollToTop = true
                    }
                Spacer()
                Text("Two")
                    .onTapGesture {
                        selectedScreen = .second
                        scrollToTop = true
                    }
                Spacer()
                Text("Three")
                    .onTapGesture {
                        selectedScreen = .third
                        scrollToTop = true
                    }
                Spacer()
            }
        }
        .frame(height: 50.0)
    }
    
}


struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
