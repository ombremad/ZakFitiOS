//
//  MainViewModel+Nutrition.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

extension MainViewModel {
    func fetchNutritionData() async {
        await fetchMeals(days: 1)
    }
    
    func fetchMeals(days: Int? = nil) async {
        isLoading = true
        do {
            var queryParams: [String] = []
            
            if let days = days {
                queryParams.append("days=\(days)")
            }
            
            let endpoint = if queryParams.isEmpty {
                "/meals"
            } else {
                "/meals?\(queryParams.joined(separator: "&"))"
            }
            
            let response: [MealListItemResponse] = try await NetworkService.shared.get(
                endpoint: endpoint,
                requiresAuth: true
            )
            
            meals = response.map { $0.toSmallModel() }
        } catch {
            print("Error fetching meals: \(error)")
        }
        isLoading = false
    }
        
    func fetchMealDetail(id: UUID) async {
        isLoading = true
        do {
            let response: MealResponse = try await NetworkService.shared.get(
                endpoint: "/meals/\(id)",
                requiresAuth: true
            )
            
            meal = response.toModel()
            print("Successfully fetched meal detail id: \(meal.id, default: "undefined")")
        } catch {
            print("Error fetching meal detail: \(error)")
        }
        isLoading = false
    }
}
