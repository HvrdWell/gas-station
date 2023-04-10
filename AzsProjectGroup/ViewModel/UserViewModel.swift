//
//  UserViewModel.swift
//  AzsProject
//
//  Created by geka231 on 10.04.2023.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: [userModel]
    
    
    init(user: [userModel]) {
        self.user = user
    }
}
