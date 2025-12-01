//
//  MainViewModel+Fitness.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import Foundation

extension MainViewModel {
    func fetchExercises(days: Int?) async {
        isLoading = true
        do {
            let endpoint = if let days = days {
                "/exercises?days=\(days)"
            } else {
                "/exercises"
            }
            
            let response: [ExerciseResponse] = try await NetworkService.shared.get(
                endpoint: endpoint,
                requiresAuth: true
            )
            
            exercises = response.map { $0.toModel() }
        } catch {
            print("Error fetching activities: \(error)")
        }
        isLoading = false
    }
}
