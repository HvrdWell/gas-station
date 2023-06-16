//
//  APIManagerForQrCode.swift
//  AzsProject
//
//  Created by geka231 on 09.05.2023.
//

import Foundation

class APIManagerForQr {
    static let shared = APIManagerForQr()
    private let baseUrl = "http://localhost:5145"

    func createCardAndVerifyToken(token: String, userId: Int, completion: @escaping (Result<(Int, Int,String), Error>) -> Void) {
        let urlString = "\(baseUrl)/api/AppFunc"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = [
            "token": UserDefaults.standard.string(forKey: Constants.TokenKey),
            "userId": UserDefaults.standard.string(forKey: Constants.UserIDKey)
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(APIError.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let scoresCard = json?["scoresCard"] as? Int,
                   let numberOfQR = json?["numberOfQR"] as? Int,
                let nameOfUser = json?["nameOfUser"] as? String{
                    completion(.success((scoresCard, numberOfQR,nameOfUser)))
                } else {
                    completion(.failure(APIError.invalidResponse))
                }
            } catch {
                completion(.failure(APIError.invalidResponse))
            }
        }
        
        task.resume()
    }
}

enum APIError: Error {
    case invalidUrl
    case invalidRequest
    case noData
    case invalidResponse
}

