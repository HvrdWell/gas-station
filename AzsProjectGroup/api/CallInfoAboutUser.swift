//
//  CallInfoAboutUser.swift
//  AzsProject
//
//  Created by geka231 on 14.06.2023.
//

import Foundation

class CallInfoAboutUser {
    static let shared = CallInfoAboutUser()
    private let baseUrl = "http://localhost:5145"

    func aboutUser(completion: @escaping (Result<(String, String, String, String), Error>) -> Void) {
        let urlString = "\(baseUrl)/api/AppFunc/aboutUser"
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
                
                if let name = json?["name"] as? String,
                   let gender = json?["gender"] as? String,
                   let dateOfBirth = json?["data"] as? String,
                   let email = json?["email"] as? String {
                    completion(.success((name, gender, dateOfBirth, email)))
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


