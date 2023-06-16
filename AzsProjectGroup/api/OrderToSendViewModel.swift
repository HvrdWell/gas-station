//
//  OrderToSendViewModel.swift
//  AzsProject
//
//  Created by geka231 on 18.05.2023.
//

import Foundation

class OrderToSendViewModel: ObservableObject {
    @Published var responseMessage = ""
    
    func createOrder(order: OrderToSend) {
        guard let url = URL(string: "http://http://localhost:5145/api/Order") else {
            return
        }
        
        let jsonData = try? JSONEncoder().encode(order)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                DispatchQueue.main.async {
                    self.responseMessage = decodedResponse.message
                }
            }
        }.resume()
    }
    
    
    struct Response: Codable {
        let message: String
    }
}
