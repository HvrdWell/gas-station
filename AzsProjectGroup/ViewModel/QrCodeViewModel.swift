//
//  QrCodeViewModel.swift
//  AzsProject
//
//  Created by geka231 on 02.01.2023.
//

import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

import Foundation

class QrCodeViewModel: ObservableObject {
    @Published var scoresCard = "0"
    @Published var numberOfQR = ""
    @Published var userName = "Пользователь"
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
    func createCardAndVerifyToken() {
        let token = UserDefaults.standard.string(forKey: Constants.TokenKey) ?? ""
        let userId = UserDefaults.standard.integer(forKey: Constants.UserIDKey)
        
        APIManagerForQr.shared.createCardAndVerifyToken(token: token, userId: userId) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.scoresCard = String(data.0)
                    self?.numberOfQR = String(data.1)
                    self?.userName = String(data.2)
                }
            case .failure(let error):
                print("API request failed: \(error)")
            }
        }
    }

}
