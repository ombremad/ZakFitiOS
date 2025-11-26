//
//  OnboardingViewModel.swift
//  ZakFit
//
//  Created by Anne Ferret on 26/11/2025.
//

import Foundation

@Observable
class OnboardingViewModel {
    var isLoading: Bool = false
    var errorMessage: String = ""
    
    var currentStep: Int = 0
    var restrictionTypesAvailable: [RestrictionType] = []
    
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
