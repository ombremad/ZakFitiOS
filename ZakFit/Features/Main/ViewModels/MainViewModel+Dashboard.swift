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
}
