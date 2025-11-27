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
            if user.id == nil {
                let userResponse: User = try await NetworkService.shared.get(
                    endpoint: "/users",
                    requiresAuth: true
                )
                // Update local user with fetched data
                user.id = userResponse.id
                user.firstName = userResponse.firstName
                user.lastName = userResponse.lastName
                user.email = userResponse.email
                user.birthday = userResponse.birthday
                user.height = userResponse.height
                user.weight = userResponse.weight
                user.sex = userResponse.sex
                user.bmr = userResponse.bmr
                user.physicalActivity = userResponse.physicalActivity
                user.goalCals = userResponse.goalCals
                user.goalCarbs = userResponse.goalCarbs
                user.goalFats = userResponse.goalFats
                user.goalProts = userResponse.goalProts
            }
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
