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
            print("Successfully fetched user data for user \(user.firstName ?? "undefined") \(user.lastName ?? "undefined")")
        } catch {
            print("Error fetching user data: \(error)")
        }
        isLoading = false
    }
    
    func logout() {
        do {
            try AuthManager.shared.logout()
            user = User()
            print("User logged out successfully")
        } catch {
            print("Error logging out: \(error.localizedDescription)")
        }
    }
}
