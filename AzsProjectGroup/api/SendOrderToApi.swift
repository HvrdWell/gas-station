//
//  SendOrderToApi.swift
//  AzsProject
//
//  Created by geka231 on 27.04.2023.
//

import Foundation

class SendOrderToApi {
    func sendOrderToAPI(_ order: OrderData) {
        guard let url = URL(string: "http://localhost:5145/api/Order") else {
            // Handle invalid URL
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(order)
            request.httpBody = jsonData
        } catch {
            // Handle JSON encoding error
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the API response
            if let error = error {
                // Handle the error
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Process the response data, if needed
            if let data = data {
                // Handle the response data
                // Example: Parse the response JSON and handle success/error cases
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response JSON: \(json)")
                    
                    // Process the response and update your UI or take appropriate actions
                } catch {
                    // Handle JSON parsing error
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

}
