//
//  APIManager.swift
//  jsonCheck
//
//  Created by geka231 on 24.04.2023.
//

import Foundation

class APIManager {
    func getColumns(completion: @escaping ([Column]?, Error?) -> Void) {
        guard let url = URL(string: "http://localhost:5145/api/Fuel/column/all") else {
            completion(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            do {
                let columns = try JSONDecoder().decode([Column].self, from: data)
                completion(columns, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
