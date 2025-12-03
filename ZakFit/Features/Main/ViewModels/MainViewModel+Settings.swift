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
            newUser.bmr = calculateBMR(birthday: newUser.birthday!, sex: newUser.sex!, height: newUser.height!, weight: newUser.weight!)
            let patch = newUser.changes(from: user)
            await postPatch(patch)
            await fetchUserData()
        }
        isLoading = false
        return true
    }
    
    func postPatch(_ patch: User) async {
        do {
            let request = patch.toRequest()
            
            let userResponse: UserResponse = try await NetworkService.shared.patch(
                endpoint: "/users",
                body: request,
                requiresAuth: true
            )
            
            user = User(from: userResponse)
            print("Successfully patched user \(user.email ?? "undefined")")
            
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
        
        let firstNameResult = validation.validateFirstName(formData.firstName)
        if !firstNameResult.isValid {
            errorMessage = firstNameResult.errorMessage ?? ""
            return false
        }
        
        let lastNameResult = validation.validateLastName(formData.lastName)
        if !lastNameResult.isValid {
            errorMessage = lastNameResult.errorMessage ?? ""
            return false
        }
        
        let emailResult = validation.validateEmail(formData.email)
        if !emailResult.isValid {
            errorMessage = emailResult.errorMessage ?? ""
            return false
        }
                
        return true
    }
}
