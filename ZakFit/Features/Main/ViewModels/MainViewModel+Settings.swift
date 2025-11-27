//
//  MainViewModel+Settings.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import Foundation

extension MainViewModel {

    func updateSettings(_ newUser: User) async -> Bool {
        isLoading = true
        
        guard validateForm(newUser) else {
            isLoading = false
            return false
        }
        
        if newUser.hasChanges(from: user) {
            let patch = newUser.changes(from: user)
            await postPatch(patch)
            await fetchUserData()
        }
        isLoading = false
        return true
    }
    
    func postPatch(_ patch: User) async {
        do {
            let userResponse: User = try await NetworkService.shared.patch(
                endpoint: "/users",
                body: patch,
                requiresAuth: true
            )
            print("API update successful for user \(user.email ?? "undefined")")
            
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
            print("Local update successful for user \(user.email ?? "undefined")")
            
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Une erreur est survenue: \(error.localizedDescription)"
        }
    }
    
    func validateForm(_ formData: User) -> Bool {
        errorMessage = ""
            
        let birthdayResult = validation.validateBirthday(formData.birthday)
        if !birthdayResult.isValid {
            errorMessage = birthdayResult.errorMessage ?? ""
            return false
        }
        
        let physicalActivityResult = validation.validatePhysicalActivity(formData.physicalActivity)
        if !physicalActivityResult.isValid {
            errorMessage = physicalActivityResult.errorMessage ?? ""
            return false
        }
        
        let sexResult = validation.validateSex(formData.sex)
        if !sexResult.isValid {
            errorMessage = sexResult.errorMessage ?? ""
            return false
        }

        let heightResult = validation.validateHeight(formData.height)
        if !heightResult.isValid {
            errorMessage = heightResult.errorMessage ?? ""
            return false
        }
        
        let weightResult = validation.validateWeight(formData.weight)
        if !weightResult.isValid {
            errorMessage = weightResult.errorMessage ?? ""
            return false
        }
        
        return true
    }
}
