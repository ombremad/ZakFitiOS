//
//  MainViewModel+Nutrition.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation
import SwiftUI

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
        foods = []
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
    
    func addFoodItem(mealType: MealType, foodType: FoodType?, weight: Int?, quantity: Int?) -> Bool {
        var actualWeight: Int? = weight
        
        if let quantity = quantity {
            actualWeight = quantity * (foodType?.weightPerServing ?? 0)
        }
        
        guard validateFoodItemForm(foodType: foodType, weight: actualWeight, quantity: quantity) else { return false }
        
        let food = Food(
            id: UUID(),
            weight: actualWeight!,
            quantity: quantity,
            foodType: foodType!
        )
        
        foods.append(food)
        print("Successfully added food \(food.foodType.name) to meal")
        return true
    }
    
    func addMeal(mealType: MealType, date: Date, cals: Int, carbs: Int, fats: Int, prots: Int) async -> Bool {
        guard validateMealForm(cals: cals) else { return false }
        
        let mealRequest = MealRequest(date: date, cals: cals, carbs: carbs, fats: fats, prots: prots, mealTypeId: mealType.id, foods: foods.map { $0.toRequest() })

        do {
            isLoading = true

            let response: MealResponse = try await NetworkService.shared.post(
                endpoint: "/meals",
                body: mealRequest,
                requiresAuth: true
            )
            let mealResponse = response.toModel()
            
            print("Successfully posted meal with ID: \(mealResponse.id, default: "undefined")")
            needsRefresh = true
            isLoading = false
        } catch {
            print("Error posting meal: \(error)")
            isLoading = false
            return false
        }
        
        return true
    }
        
    // Field validation
    
    func validateFoodItemForm(foodType: FoodType?, weight: Int?, quantity: Int?) -> Bool {
        errorMessage = ""
        
        if let foodType = foodType {
            
            if foodType.weightPerServing != nil {
                if let quantity = quantity {
                    if quantity <= 0 {
                        errorMessage = "La quantité ne peut être nulle."
                        return false
                    }
                    if quantity > 100 {
                        errorMessage = "La quantité entrée doit être raisonnable."
                        return false
                    }
                } else {
                    errorMessage = "Il est obligatoire d'entrer une quantité."
                    return false
                }
            }
                
            if let weight = weight {
                if weight <= 0 {
                    errorMessage = "Le poids ne peut être nul."
                    return false
                }
                if weight > 2000 {
                    errorMessage = "Le poids entré doit être raisonnable."
                    return false
                }
            } else {
                errorMessage = "Il est obligatoire d'entrer un poids."
                return false
            }
            
        } else {
            errorMessage = "Il est obligatoire de choisir un type d'aliment."
            return false
        }
                
        return true
    }
    
    func validateMealForm(cals: Int) -> Bool {
        errorMessage = ""
        
        if meals.isEmpty {
            errorMessage = "Vous devez ajouter au moins un aliment à votre repas."
            return false
        }
        
        if cals <= 0 {
            errorMessage = "Le nombre de calories du repas ne peut être nul."
            return false
        }
        
        return true
    }
    
}
