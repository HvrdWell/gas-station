//
//  LoginViewModel.swift
//  AzsProject
//
//  Created by geka231 on 06.05.2023.
//

import Foundation


class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var username = ""
    @Published var password = ""

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func login() {
        let loginData = LoginData(login: username, password: password)

        authService.login(loginData: loginData) { result in
            switch result {
            case .success(let token):
                UserDefaults.standard.set(token, forKey: "accessToken")
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
