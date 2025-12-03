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
        dashboard.needsUserRefresh = false
        
        do {
            let userResponse: UserResponse = try await NetworkService.shared.get(
                endpoint: "/users",
                requiresAuth: true
            )
            user = User(from: userResponse)
            print("Successfully fetched user data for user \(user.email ?? "undefined")")
        } catch {
            print("Error fetching user data: \(error)")
        }
        
        isLoading = false
    }
    
    func logout() {
        do {
            try AuthManager.shared.logout()
            user = User()
            print("Successfully logged out")
        } catch {
            print("Error logging out: \(error.localizedDescription)")
        }
    }
}
