//
//  AuthService.swift
//  AzsProject
//
//  Created by geka231 on 06.05.2023.
//

import Foundation


protocol AuthServiceProtocol {
    func login(loginData: LoginData, completion: @escaping (Result<String, Error>) -> Void)
}

class AuthService: AuthServiceProtocol {
    private let baseURL = URL(string: "https://localhost:5145/api/Auth")!
    private let session = URLSession.shared

    func login(loginData: LoginData, completion: @escaping (Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("login")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(loginData)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unexpected response type"])))
                return
            }

            switch httpResponse.statusCode {
            case 200:
                if let data = data, let token = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let tokenString = token["Token"] as? String {
                    completion(.success(tokenString))
                } else {
                    completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Неправильные данные"])))
                }
            default:
                completion(.failure(NSError(domain: "AuthService", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Ошибка авторизации"])))
            }
        }
        task.resume()
    }
}
