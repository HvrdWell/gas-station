//
//  AuthManager.swift
//  AzsProject
//
//  Created by geka231 on 05.05.2023.
//

import Foundation

class AuthManager: ObservableObject {
    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:5145/api/Auth/login") else {
            let error = NSError(domain: "AuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = LoginDTO(login: username, password: password)
        
        do {
            let jsonData = try JSONEncoder().encode(body)
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
            
            guard let data = data else {
                let error = NSError(domain: "AuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "AuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unexpected response type"])
                completion(.failure(error))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    let token = try JSONDecoder().decode(TokenResponse.self, from: data)
                    completion(.success(token.token))
                } catch {
                    completion(.failure(error))
                }
            default:
                do {
                    let errorMessage = try JSONDecoder().decode(ErrorMessage.self, from: data)
                    let error = NSError(domain: "AuthManager", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage.message])
                    completion(.failure(error))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}



struct LoginDTO: Encodable {
    let login: String
    let password: String
}

struct TokenResponse: Decodable {
    let token: String
}

struct ErrorMessage: Decodable {
    let message: String
}

