//
//  OnboardingViewModel.swift
//  ZakFit
//
//  Created by Anne Ferret on 26/11/2025.
//

import Foundation

@Observable
class OnboardingViewModel {
    private let validation = FieldValidation.shared

    var isLoading: Bool = false
    var errorMessage: String = ""
    
    var currentStep: Int = 0
    var restrictionTypesAvailable: [RestrictionType] = []
    var bmr: Int = 0
    
    func fetchRestrictionTypes() async {
        isLoading = true
        
        do {
            let response: [RestrictionTypeResponse] = try await NetworkService.shared.get(
                endpoint: "/restrictionTypes",
                requiresAuth: false
            )
            restrictionTypesAvailable = response.map(RestrictionType.init)
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Une erreur est survenue: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func nextStep(formData: OnboardingFormData) {
        if currentStep == 1 {
            guard validateMorphologyForm(formData) else { return }
            bmr = calculateBMR(birthday: formData.birthday!, sex: formData.sex!, height: formData.height!, weight: formData.weight!)
        }
        currentStep += 1
    }
    
    func validateMorphologyForm(_ formData: OnboardingFormData) -> Bool {
        errorMessage = ""
        
        let birthdayResult = validation.validateBirthday(formData.birthday)
        if !birthdayResult.isValid {
            errorMessage = birthdayResult.errorMessage ?? ""
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
