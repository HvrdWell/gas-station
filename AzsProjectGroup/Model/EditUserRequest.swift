//
//  EditUserRequest.swift
//  AzsProject
//
//  Created by geka231 on 13.06.2023.
//

import Foundation

struct EditUserRequest: Encodable {
    let id: String
    let name: String
    let gender: String
    let dateOfBirth: Date
    let email: String
}

func updateUserProfile(request: EditUserRequest) {
    guard let url = URL(string: "http://localhost:5145/user/edit") else {
        print("Invalid URL")
        return
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "PUT"
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(request)
        urlRequest.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid HTTP response")
                return
            }

            if httpResponse.statusCode == 200 {
                print("Profile updated successfully")
                            } else {
                                print("Failed to update profile. Status code: \(httpResponse.statusCode)")
                            }
                        }

                        task.resume()
                    } catch {
                        print("Error encoding request: \(error)")
                    }
                }
