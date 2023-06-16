//
//  DataFetcher.swift
//  AzsProject
//
//  Created by geka231 on 09.05.2023.
//

import Foundation

class DataFetcher: ObservableObject {
    @Published var scoresCard: String = "Неизвестно"
    @Published var numberOfQR: String = ""

    func fetchData() {
        guard let url = URL(string: "https://your-api-endpoint.com/getdata") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        self.scoresCard = response.scoresCard
                        self.numberOfQR = response.numberOfQR
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }
        .resume()
    }
}

struct Response: Codable {
    let scoresCard: String
    let numberOfQR: String
}

