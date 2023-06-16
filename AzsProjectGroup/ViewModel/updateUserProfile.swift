//
//  updateUserProfile.swift
//  AzsProject
//
//  Created by geka231 on 13.06.2023.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile
    
    init() {
        // Initialize the user profile with default values
        userProfile = UserProfile(name: "", gender: "", dateOfBirth: Date(), email: "")
    }
    
    func saveUserProfile() {
        // Perform the network request to save the user profile
        YourAPIManager.shared.updateUserProfile(userProfile) { result in
            // Handle the result of the network request
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Profile updated successfully")
                    // Handle successful profile update
                    
                case .failure(let error):
                    print("Failed to update profile: \(error)")
                    // Handle profile update failure
                }
            }
        }
    }
}
