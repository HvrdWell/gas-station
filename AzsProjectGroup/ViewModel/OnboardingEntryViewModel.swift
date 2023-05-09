//
//  OnboardingEntryViewModel.swift
//  AzsProject
//
//  Created by geka231 on 08.05.2023.
//

import Foundation
import SwiftUI

class OnboardingEntryViewModel: ObservableObject {
    var countryCodes: [CountryCode]
    @Published var phoneNum: String = ""
    @Published var open: Bool = false
    @Published var activeCountryCodes: [CountryCode]
    @Published var selectedCode: String? = "+7"
    @Published var nextPage: Bool = false
    @Published var finished: Bool = false
    @Published var visibleError: Error? = nil
    @Published var code: String = ""
    @ObservedObject var viewRouter: ViewRouter
    var isCodeValid:Bool = false

    init(viewRouter: ViewRouter) {
        self.viewRouter = viewRouter

        countryCodes = []
        if let path = Bundle.main.url(forResource: "PhoneCountryCodes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path, options: .alwaysMapped)
                let codes = try JSONDecoder().decode([CountryCode].self, from: data)
                countryCodes.append(contentsOf: codes)
                
            } catch let error{
                print("Список кодов стран недоступен: \(error.localizedDescription)")
            }
        }
        self.activeCountryCodes = countryCodes
    }
    
    func selectCountry(_ country: CountryCode) {
        selectedCode = country.dial_code
    }
    
    func deselectCountry() {
        selectedCode = nil
    }
    func convertPhoneNumber(_ phoneNumber: String) -> String {
        let digitsOnly = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return digitsOnly
    }
    func errorCompletion(_ error: Error?) {
        visibleError = error
        print(error?.localizedDescription ?? "Ошибка!")
    }
    
    

    func successCompl(_ success: Bool) -> Void {
        visibleError = nil
        nextPage = true
    }
    func sendTextCode() {
        guard let code = selectedCode else {
            visibleError = OnboardingError.noCountryCodeChosen
            return
        }
        
        let phoneNumber = convertPhoneNumber("\(code)\(phoneNum)")
        let numberService = NumberService()
        numberService.sendNumber(phoneNumber: phoneNumber ) { error in
            if let error = error {
                print("Ошибка отправки:", error.localizedDescription)
            }
        } successCompletion: { [self] success in
            if success {
                successCompl(true)
                print("Успешно")
            } else {                
                print("Ошибка неизвестная:")
            }
        }
    }
    func resendCode() {
        let phoneNumber = convertPhoneNumber("\(code)\(phoneNum)")
        let numberService = NumberService()
        numberService.sendNumber(phoneNumber: phoneNumber ) { error in
            if let error = error {
                print("Ошибка отправки:", error.localizedDescription)
            }
        } successCompletion: { success in
            if success {
                print("Успешно")
            } else {
                print("Ошибка неизвестная:")
            }
        }
    }
    func verifyCode() {
        let numberService = NumberService()
        let phoneNumber = "\(selectedCode)\(phoneNum)"
        numberService.verifyCode(phoneNumber: convertPhoneNumber(phoneNumber), code: code) { success, token, userId in
            if success {
                UserDefaults.standard.set(token, forKey: Constants.TokenKey)
                UserDefaults.standard.set(userId, forKey: Constants.UserIDKey)
                self.viewRouter.token = token
                self.viewRouter.userId = String(userId)
                self.isCodeValid = true
            } else {
                self.isCodeValid = false
                print("Ошибка")
            }
        }
    }
    
    class CountryCode: Hashable, Codable {
        var id: String {
            return code
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(code)
        }
        
        static func == (lhs: CountryCode, rhs: CountryCode) -> Bool {
            if lhs.code == rhs.code { return true}
            return false
        }
        
        var name: String
        var dial_code: String
        var code: String
        init(name: String, dial_code: String, code: String) {
            self.name = name
            self.dial_code = dial_code
            self.code = code
        }
        
        func flag() -> String {
            let base : UInt32 = 127397
            var s = ""
            for v in self.code.unicodeScalars {
                s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
            }
            return String(s)
        }
        
        var jsonData: String {
            let jsonData = try! JSONEncoder().encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonString
        }
        
        
    }
    
}
