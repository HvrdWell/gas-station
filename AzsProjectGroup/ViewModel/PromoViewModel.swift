//
//  PromoViewModel.swift
//  AzsProject
//
//  Created by geka231 on 14.06.2023.
//

import Foundation

class PromoCardViewModel: ObservableObject {
    @Published var promoCards: [Promocard] = []
    
    func fetchPromoCards() {
        guard let url = URL(string: "http://localhost:5145/api/AppFunc/promocard") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let promoCards = try decoder.decode([Promocard].self, from: data)
                
                DispatchQueue.main.async {
                    self.promoCards = promoCards
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
