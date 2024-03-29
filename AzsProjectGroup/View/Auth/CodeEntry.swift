//
//  CodeEntry.swift
//  AzsProject
//
//  Created by geka231 on 08.05.2023.
//

import SwiftUI

struct CodeEntry: View {
    
    @Binding var code: String
    
    let codeMaskStr = "●●●"
    let formatStr = "XXX"
  
    var body: some View {
        VStack {
            codeEntryField
        }
    }
    
    
    var codeEntryField: some View {
            CustomTextField(placeholder: codeEntryPlaceholder, text: $code)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: code) { value in
                    code = code.format(with: formatStr)
                }
    }
    
    var codeEntryPlaceholder: Text {
        Text(codeMaskStr)
            .tracking(4.0)
            .font(Font.custom("Rubik-Bold", size: 40))
            .foregroundColor(.green)
    }
    
    
}

struct CodeEntry_Previews: PreviewProvider {
    static var previews: some View {
        CodeEntry(code: .constant(""))
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { HStack { Spacer()
                placeholder
                Spacer()
            }}
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .multilineTextAlignment(.center)
                .font(Font.custom("Rubik-Bold", size: 40))
                .foregroundColor(.blue)
                .accentColor(.clear)
        }
    }
}

