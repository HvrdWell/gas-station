//
//  ViewRouter.swift
//  AzsProject
//
//  Created by geka231 on 08.05.2023.
//

import Foundation
import SwiftUI
import Combine

class ViewRouter: ObservableObject {
    @Published var token: String?
    @Published var userId: String?
    
    private var uidObserver: NSObject? = nil
    private var subscribers: Set<AnyCancellable> = []
    
    @Published var currentView: ActiveTabView = .main
    
    init() {
        if let token = UserDefaults.standard.string(forKey: Constants.TokenKey),
            let userId = UserDefaults.standard.string(forKey: Constants.UserIDKey) {
            // Validate the token and userId here if needed
            self.token = token
            self.userId = userId
            currentView = .main
        } else {
            print("ViewRouter init reported no valid user data. ActiveTab will be set to onboarding")
            currentView = .onboarding
        }

        // Start an observer on userDefaultUserUID to alert this class when the user default is changed

        // Start an observer on currentView
        $currentView.sink { (newActiveView) in
            print("Current view updated to -> \(self.currentView)")
        }.store(in: &subscribers)
    }
    
    deinit {
        uidObserver = nil
        subscribers = []
    }
    func logout() {
        self.token = nil
        self.userId = nil
        UserDefaults.standard.removeObject(forKey: Constants.TokenKey)
        UserDefaults.standard.removeObject(forKey: Constants.UserIDKey)
        currentView = .onboarding
    }
    func login(){
        currentView = .main
    }
    func validateUID(_ uid: String?) -> Bool {
        guard let uid = uid,
            uid.count > 0 else {
                print("Failed to start uid listener. Valid uid not found")
                return false
        }
        return true
    }
    
    func setUidDocListener(uid: String?) {
        guard let _uid = uid,
            validateUID(uid) else {
                self.currentView = .onboarding
                return
        }
        
    }
}

enum ActiveTabView {
    case main
    case accountSetup
    case onboarding
}
