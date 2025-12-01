//
//  MainViewModel+BasicUserFeatures.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import Foundation

extension MainViewModel {
    func fetchUserData() async {
        isLoading = true
        do {
            let userResponse: UserResponse = try await NetworkService.shared.get(
                endpoint: "/users",
                requiresAuth: true
            )
            user = User(from: userResponse)
        } catch {
            print("Error: \(error)")
        }
        isLoading = false
    }
    
    func logout() {
        do {
            try AuthManager.shared.logout()
        } catch {
            print("Error logging out: \(error.localizedDescription)")
        }
        user = User()
        print("User logged out successfully")
    }
}
