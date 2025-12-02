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
    
    func initNewMeal() async {
        if mealTypes.isEmpty {
            await fetchMealTypes()
        }
    }
    
    func fetchMealTypes() async {
        isLoading = true
        do {
            let response: [MealTypeResponse] = try await NetworkService.shared.get(
                endpoint: "/mealTypes",
                requiresAuth: true
            )
            
            mealTypes = response.map { $0.toModel() }
            print("Successfully fetched meal types")
        } catch {
            print("Error fetching meal types: \(error)")
        }
        isLoading = false
    }
    
    func goToFoodSelection(selectedMealType: MealType?, date: Date) {
        errorMessage = ""
        
        if selectedMealType == nil {
            errorMessage = "Il est obligatoire de choisir un type de repas."
            return
        }
        
        let dateResult = validation.validateDate(date)
        if !dateResult.isValid {
            errorMessage = dateResult.errorMessage ?? ""
            return
        }
        
        shouldNavigateToFoodSelection = true
    }
    
    func fetchFoodTypes(mealType: MealType, restrictionTypes: [RestrictionType]?) async {
        errorMessage = ""

        do {
            isLoading = true

            let response: [FoodTypeResponse] = try await NetworkService.shared.get(
                endpoint: "/foodTypes",
                requiresAuth: true
            )
            foodTypes = response.map { $0.toModel() }
            print("Successfully fetched food types")

            isLoading = false
        } catch {
            print("Error fetching food types: \(error)")
            isLoading = false
        }
    }
}
