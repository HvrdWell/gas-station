//
//  EditUserViewModel.swift
//  AzsProject
//
//  Created by geka231 on 13.06.2023.
//

import Foundation
import SwiftUI

struct EditUserModel: Encodable {
    let idOfUser: Int
    let name: String
    let selectedGender: String
    let email: String
}



protocol EditUserServiceProtocol {
    func updateUser(_ user: EditUserModel, completion: @escaping (Result<String, Error>) -> Void)
}

class EditUserService: EditUserServiceProtocol {
    private let baseURL = URL(string: "http://localhost:5145/api/ExolveSMSAuth/EditUser/")!
    private let session = URLSession.shared

    func updateUser(_ user: EditUserModel, completion: @escaping (Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("EditUser")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "EditUserService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unexpected response type"])))
                return
            }

            switch httpResponse.statusCode {
            case 200..<300:
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    completion(.success(responseString))
                } else {
                    completion(.failure(NSError(domain: "EditUserService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response data"])))
                }
            default:
                completion(.failure(NSError(domain: "EditUserService", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error"])))
            }
        }
        task.resume()
    }
}
