//
//  APIManagerOrder.swift
//  AzsProject
//
//  Created by geka231 on 25.05.2023.
//

import Foundation

class APIManagerOrder {
    static let shared = APIManagerOrder()
    
    private let baseURL = "http://localhost:5145/api/order/order"
    
    func createOrder(order: OrderDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(APIErrors.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(order)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(APIErrors.requestFailed(httpResponse.statusCode)))
            }
        }.resume()
    }
}

enum APIErrors: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Int)
}

