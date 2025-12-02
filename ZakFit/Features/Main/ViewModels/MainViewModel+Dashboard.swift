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
        if calsToday == nil || needsRefresh == true {
            await fetchNutrientsToday()
        }
    }
    
    func fetchNutrientsToday() async {
        needsRefresh = false
        isLoading = true
        do {
            let response: [MealListItemResponse] = try await NetworkService.shared.get(
                endpoint: "/meals?days=1",
                requiresAuth: true
            )
            calsToday = response.reduce(0) { $0 + $1.cals }
            carbsToday = response.reduce(0) { $0 + $1.carbs }
            fatsToday = response.reduce(0) { $0 + $1.fats }
            protsToday = response.reduce(0) { $0 + $1.prots }
            print("Successfully fetched macronutrients for today")
        } catch {
            print("Error fetching macronutrients for today: \(error)")
        }
        isLoading = false
    }
}
