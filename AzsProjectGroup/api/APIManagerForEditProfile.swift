//
//  APIManagerForEditProfile.swift
//  AzsProject
//
//  Created by geka231 on 14.06.2023.
//

import Foundation

class APIManagerForEdit{
    static let shared = APIManagerForEdit()
    private let baseUrl = "http://localhost:5145"

    func createCardAndVerifyToken(Name:String,Gender:String,DateOfBitrh:Date,Email:String, completion: @escaping (Result<(Int, Int), Error>) -> Void) {
        let urlString = "\(baseUrl)/api/AppFunc/edit"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let dateFormatter = ISO8601DateFormatter()
        let dateOfBirthString = dateFormatter.string(from: DateOfBitrh)

        let parameters = [
            "id": UserDefaults.standard.string(forKey: Constants.UserIDKey),
            "name":Name,
            "gender":Gender,
            "dateOfBirth": dateOfBirthString,
            "email":Email
        ] as [String : Any]
        
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

                    let httpResponse = response as? HTTPURLResponse
                    if let statusCode = httpResponse?.statusCode {
                        switch statusCode {
                        case 200...299:
                            completion(.success((statusCode, data.count)))
                        default:
                            completion(.failure(APIError.invalidResponse))
                        }
                    } else {
                        completion(.failure(APIError.invalidResponse))
                    }
                }

                task.resume()
    }
}

