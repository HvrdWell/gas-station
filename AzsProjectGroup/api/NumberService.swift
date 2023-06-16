//
//  NumberService.swift
//  AzsProject
//
//  Created by geka231 on 08.05.2023.
//

import Foundation

class NumberService {
    func sendNumber(phoneNumber: String, errorCompletion: @escaping (Error?) -> Void, successCompletion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:5145/api/ExolveSMSAuth/SendCode") else {
            print("Ошибка отправки запроса")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(phoneNumber)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    errorCompletion(error)
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                                if response.statusCode == 200 {
                                    successCompletion(true)
                                } else {
                                    successCompletion(false)
                                }
                            }
                        }.resume()
        } catch {
            errorCompletion(error)
        }
    }
    
    func verifyCode(phoneNumber: String, code: String, completion: @escaping (Bool, String, Int) -> Void) {
        guard let url = URL(string: "http://localhost:5145/api/ExolveSMSAuth/VerifyCode") else {
            print("Ошибка отправки запроса")
            completion(false, "", 0)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "phoneNumber": phoneNumber,
            "code": code
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Ошибка отправки запроса", error.localizedDescription)
                    completion(false, "", 0)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        if let jsonData = data {
                            do {
                                if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                    if let token = json["token"] as? String, let userId = json["userId"] as? Int {
                                        completion(true, token, userId)
                                    } else {
                                        completion(false, "", 0)
                                    }
                                } else {
                                    completion(false, "", 0)
                                }
                            } catch {
                                print("Ошибка отправки запроса", error.localizedDescription)
                                completion(false, "", 0)
                            }
                        } else {
                            completion(false, "", 0)
                        }
                    } else {
                        completion(false, "", 0) 
                    }
                }
            }.resume()
        } catch {
            print("Ошибка отправки запроса", error.localizedDescription)
            completion(false, "", 0) 
        }
    }



}

