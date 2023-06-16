//
//  FuelManager.swift
//  AzsProject
//
//  Created by geka231 on 14.06.2023.
//

import Foundation

class FuelManager: ObservableObject {
    static let shared = FuelManager()
    private let baseUrl = "http://localhost:5145/api"
    @Published var fuels: [TypeFuelDTO] = []

    func getFuelData(completion: @escaping (Result<[TypeFuelDTO], Error>) -> Void) {
        let urlString = "\(baseUrl)/Fuel/GetFuels"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let fuelData = try decoder.decode([TypeFuelDTO].self, from: data)
                completion(.success(fuelData))
            } catch {
                completion(.failure(APIError.invalidResponse))
            }
        }

        task.resume()
    }
}
struct TypeFuelDTO: Codable {
    let idTypeFuel: Int
    let nameTypeFuel: String
    let price: Double
}
