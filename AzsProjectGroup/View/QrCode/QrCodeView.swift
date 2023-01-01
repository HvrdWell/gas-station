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
    @State private var bonusCount = 0
    var body: some View {
        
        
            NavigationStack {
                    VStack {
                        TextField("Enter code", text: $text)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        
                        Image(uiImage: UIImage(data: generateQR(text: text)!)!)
                            .resizable()
                            .frame(width: 350, height: 350)
                            .padding(.all)
                            .background(Color.white)
                    }
            }.background(.thinMaterial)
            .background(Image("bronzeBackGround"))
    }
    
    func generateQR(text: String) -> Data? {
        let filter = CIFilter.qrCodeGenerator()
        guard let data = text.data(using: .ascii, allowLossyConversion: false) else { return nil }
        filter.message = data
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()!
    }
}
struct QrCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeView()
    }
}
