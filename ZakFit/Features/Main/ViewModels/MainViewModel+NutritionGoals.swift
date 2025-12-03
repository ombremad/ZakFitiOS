//
//  MainViewModel+NutritionGoals.swift
//  ZakFit
//
//  Created by Anne Ferret on 03/12/2025.
//

import Foundation

extension MainViewModel {
    func getRepartition() {
        let repartition = getNutrientPercentages(fitnessProgram: nutritionGoals.fitnessProgram)
        nutritionGoals.carbsPercentage = repartition.carbsPercentage
        nutritionGoals.fatsPercentage = repartition.fatsPercentage
        nutritionGoals.protsPercentage = repartition.protsPercentage
        nutritionGoals.calsDaily = calculateDailyCals(bmr: nutritionGoals.bmr, physicalActivity: user.physicalActivity ?? 0)
        calculateDailyValues()
    }
    
    func calculateDailyValues() {
        nutritionGoals.carbsDaily = nutritionGoals.calsDaily * nutritionGoals.carbsPercentage / 100
        nutritionGoals.fatsDaily = nutritionGoals.calsDaily * nutritionGoals.fatsPercentage / 100
        nutritionGoals.protsDaily = nutritionGoals.calsDaily * nutritionGoals.protsPercentage / 100
    }
    
    func postNutritionGoals() async -> Bool {
        guard validateProgramForm() else { return false }
        isLoading = true
        
        let patch = User(
            bmr: nutritionGoals.bmr,
            goalCals: nutritionGoals.calsDaily,
            goalCarbs: nutritionGoals.carbsDaily,
            goalFats: nutritionGoals.fatsDaily,
            goalProts: nutritionGoals.protsDaily
        )
        
        let request = patch.toRequest()

        do {
            let userResponse: UserResponse = try await NetworkService.shared.patch(
                endpoint: "/users",
                body: request,
                requiresAuth: true
            )
            
            user = User(from: userResponse)
            
            print("Successfully patched user \(user.email ?? "undefined")")
            dashboard.needsMacronutrientRefresh = true
            isLoading = false
            return true
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        } catch {
            errorMessage = "Une erreur est survenue: \(error.localizedDescription)"
            isLoading = false
            return false
        }
    }
    
    func validateProgramForm() -> Bool {
        errorMessage = ""
        
        let bmrResult = validation.validateCalories(nutritionGoals.bmr)
        if !bmrResult.isValid {
            errorMessage = bmrResult.errorMessage ?? ""
            return false
        }
        
        let percentageResult = validation.validatePercentage(nutritionGoals.carbsPercentage + nutritionGoals.fatsPercentage + nutritionGoals.protsPercentage)
        if !percentageResult.isValid {
            errorMessage = percentageResult.errorMessage ?? ""
            return false
        }
        
        return true
    }
}
