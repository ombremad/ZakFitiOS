//
//  MainViewModel+Fitness.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import Foundation

extension MainViewModel {
    func fetchExercises(exerciseType: UUID? = nil, minLength: Int? = nil, maxLength: Int? = nil, days: Int? = nil, sortBy: String? = nil, sortOrder: String? = nil) async {
        isLoading = true
        do {
            var queryParams: [String] = []
            
            if let days = days {
                queryParams.append("days=\(days)")
            }
            if let exerciseType = exerciseType {
                queryParams.append("exerciseType=\(exerciseType.uuidString)")
            }
            if let minLength = minLength {
                queryParams.append("minLength=\(minLength)")
            }
            if let maxLength = maxLength {
                queryParams.append("maxLength=\(maxLength)")
            }
            
            if let sortBy = sortBy {
                queryParams.append("sortBy=\(sortBy)")
            }
            
            if let sortOrder = sortOrder {
                queryParams.append("sortOrder=\(sortOrder)")
            }
            
            let endpoint = if queryParams.isEmpty {
                "/exercises"
            } else {
                "/exercises?\(queryParams.joined(separator: "&"))"
            }
            
            let response: [ExerciseResponse] = try await NetworkService.shared.get(
                endpoint: endpoint,
                requiresAuth: true
            )
            
            print("Fetched at: \(endpoint)")

            exercises = response.map { $0.toModel() }
        } catch {
            print("Error fetching activities: \(error)")
        }
        isLoading = false
    }
}
