//
//  commentViewModel.swift
//  jsonCheck
//
//  Created by geka231 on 24.04.2023.
//

import Foundation

class apiCall {
    var starturl: String = "http://localhost:5145/api/Fuel/column/"
    var numberofcolumn: Int = 0
    var url: String = ""
    init(numberofcolumn: Int) {
        self.numberofcolumn = numberofcolumn
    }
    // Initialize the `url` property with the given column number
    func initializeUrl(numberofcolumn: Int)-> String {
        self.numberofcolumn = numberofcolumn // Update the instance variable with the new value
        url = "\(starturl)\(numberofcolumn)"
        return url
    }

    func getUserComments(completion:@escaping ([Comments]?, Error?) -> Void) {
        guard let url = URL(string: initializeUrl(numberofcolumn: self.numberofcolumn)) else { return }

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
                let comments = try JSONDecoder().decode([Comments].self, from: data)
                completion(comments, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
