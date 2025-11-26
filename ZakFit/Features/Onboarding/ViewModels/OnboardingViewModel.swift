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
    var carbsPercentage: Int = 0
    var fatsPercentage: Int = 0
    var protsPercentage: Int = 0
    var carbsDaily: Int = 0
    var fatsDaily: Int = 0
    var protsDaily: Int = 0
    var nutritionValues: Int {
        bmr + carbsPercentage + fatsPercentage + protsPercentage
    }
    
    var fitnessProgram: FitnessProgram = .maintain
    enum FitnessProgram {
        case gainMass, maintain, loseWeight, custom
    }
     
    func nextStep(formData: OnboardingFormData) {
        if currentStep == 1 {
            guard validateMorphologyForm(formData) else { return }
            bmr = calculateBMR(birthday: formData.birthday!, sex: formData.sex!, height: formData.height!, weight: formData.weight!)
            calculateRepartition()
        }
        currentStep += 1
    }
    
    func calculateRepartition() {
        bmr = 2500  // DEBUG
        switch fitnessProgram {
            case .gainMass:
                carbsPercentage = 45
                fatsPercentage = 15
                protsPercentage = 40
            case .loseWeight:
                carbsPercentage = 30
                fatsPercentage = 25
                protsPercentage = 45
            default:
                carbsPercentage = 40
                fatsPercentage = 30
                protsPercentage = 30
        }
        calculateDailyValues()
    }
    
    func calculateDailyValues() {
        carbsDaily = bmr * carbsPercentage / 100
        fatsDaily = bmr * fatsPercentage / 100
        protsDaily = bmr * protsPercentage / 100
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
}
