//
//  QrCodeView.swift
//  AzsProject
//
//  Created by geka231 on 02.01.2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
struct QrCodeView: View {
    @State private var text = ""
   // let userModel = 

    var body: some View {

        
            NavigationStack {
                    VStack {
                        TextField("Код", text: $text)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        
                        Image(uiImage: UIImage(data: generateQR(text: text)!)!)
                            .resizable()
                            .frame(width: 350, height: 350)
                            .padding(.all)
                            .background(Color.white)
                      //  Text(User)
                    }
            }.background(.thinMaterial)
    }

}
struct QrCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeView()
           
    }
}
