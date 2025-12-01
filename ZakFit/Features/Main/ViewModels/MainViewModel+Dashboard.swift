//
//  MainViewModel+Dashboard.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import Foundation

extension MainViewModel {
    func fetchDashboardData() async {
        if user.id == nil {
            await fetchUserData()
        }
        if calsToday == nil {
            await fetchCalsToday()
        }
        if exerciseTypes.isEmpty {
            await fetchExerciseTypes()
        }
    }
    
    func fetchCalsToday() async {
        isLoading = true
        do {
            let response: [MealListItemResponse] = try await NetworkService.shared.get(
                endpoint: "/meals?days=1",
                requiresAuth: true
            )
            calsToday = response.reduce(0) { $0 + $1.cals }
            print("Total calories today: \(String(describing: calsToday))")
            print("Calories goal today: \(String(describing: user.goalCals))")
        } catch {
            print("Error fetching total calories for today: \(error)")
        }
        isLoading = false
    }
    
    func fetchExerciseTypes() async {
        isLoading = true
        do {
            let response: [ExerciseTypeResponse] = try await NetworkService.shared.get(
                endpoint: "/exerciseTypes",
                requiresAuth: true
            )
            exerciseTypes = response.map { $0.toModel() }
            print("Successfully fetched list of exerciseTypes")
        } catch {
            print("Error fetching list of exerciseTypes: \(error)")
        }
        isLoading = false
    }
}
