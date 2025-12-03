//
//  MainViewModel+Dashboard.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import Foundation

extension MainViewModel {
    func fetchDashboardData() async {
        if user.id == nil || dashboard.needsUserRefresh {
            await fetchUserData()
        }
        if dashboard.calsToday == nil || dashboard.needsMacronutrientRefresh == true {
            await fetchNutrientsToday()
        }
    }
    
    func fetchNutrientsToday() async {
        dashboard.needsMacronutrientRefresh = false
        isLoading = true
        do {
            let response: [MealListItemResponse] = try await NetworkService.shared.get(
                endpoint: "/meals?days=1",
                requiresAuth: true
            )
            dashboard.calsToday = response.reduce(0) { $0 + $1.cals }
            dashboard.carbsToday = response.reduce(0) { $0 + $1.carbs }
            dashboard.fatsToday = response.reduce(0) { $0 + $1.fats }
            dashboard.protsToday = response.reduce(0) { $0 + $1.prots }
            print("Successfully fetched macronutrients for today")
        } catch {
            print("Error fetching macronutrients for today: \(error)")
        }
        isLoading = false
    }
}
