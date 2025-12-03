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
    
    func fetchRestrictionTypes() async {
        isLoading = true
        
        do {
            let response: [RestrictionTypeResponse] = try await NetworkService.shared.get(
                endpoint: "/restrictionTypes",
                requiresAuth: false
            )
            
            print("Successfully fetched \(response.count) restriction types")
            nutrition.restrictionTypes = response.map(RestrictionType.init)
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Une erreur est survenue: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func fetchMeals(days: Int? = nil) async {
        isLoading = true
        
        var queryParams: [String] = []
        
        if let days = days {
            queryParams.append("days=\(days)")
        }
        
        let endpoint = if queryParams.isEmpty {
            "/meals"
        } else {
            "/meals?\(queryParams.joined(separator: "&"))"
        }
        
        do {
            let response: [MealListItemResponse] = try await NetworkService.shared.get(
                endpoint: endpoint,
                requiresAuth: true
            )
            
            print("Successfully fetched meals at endpoint: \(endpoint)")
            nutrition.meals = response.map { $0.toSmallModel() }
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
            
            print("Successfully fetched meal detail id: \(nutrition.meal.id, default: "undefined")")
            nutrition.meal = response.toModel()
        } catch {
            print("Error fetching meal detail: \(error)")
        }
        
        isLoading = false
    }
    
    func initNewMeal() async {
        if nutrition.mealTypes.isEmpty {
            await fetchMealTypes()
        }
        nutrition.foods = []
    }
        
    func fetchMealTypes() async {
        isLoading = true
        
        do {
            let response: [MealTypeResponse] = try await NetworkService.shared.get(
                endpoint: "/mealTypes",
                requiresAuth: true
            )
            
            nutrition.mealTypes = response.map { $0.toModel() }
            print("Successfully fetched \(response.count) meal types")
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
        
        nutrition.shouldNavigateToFoodSelection = true
    }
    
    func fetchFoodTypes(mealType: MealType, restrictionTypes: [RestrictionType]?) async {
        errorMessage = ""
        isLoading = true
        
        var queryParams: [String] = []
        
        queryParams.append("mealTypes=\(mealType.name)")
        
        if let restrictionTypes = restrictionTypes {
            for restrictionType in restrictionTypes {
                queryParams.append("restrictionTypes[]=\(restrictionType.name)")
            }
        }
        
        let endpoint = if queryParams.isEmpty {
            "/foodTypes"
        } else {
            "/foodTypes?\(queryParams.joined(separator: "&"))"
        }

        do {
            let response: [FoodTypeResponse] = try await NetworkService.shared.get(
                endpoint: endpoint,
                requiresAuth: true
            )
            nutrition.foodTypes = response.map { $0.toModel() }

            print("Successfully fetched food types at endpoint: \(endpoint)")
        } catch {
            print("Error fetching food types: \(error)")
        }
        
        isLoading = false
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
        
        nutrition.foods.append(food)
        print("Successfully added food \(food.foodType.name) to meal")
        return true
    }
    
    func deleteFoodItem(_ food: Food) {
        nutrition.foods.removeAll { $0.id == food.id }
        print("Successfully removed food \(food.foodType.name) from meal")
    }
    
    func addMeal(mealType: MealType, date: Date, cals: Int, carbs: Int, fats: Int, prots: Int) async -> Bool {
        guard validateMealForm(cals: cals) else { return false }
        
        isLoading = true

        let mealRequest = MealRequest(date: date, cals: cals, carbs: carbs, fats: fats, prots: prots, mealTypeId: mealType.id, foods: nutrition.foods.map { $0.toRequest() })
        
        do {
            let response: MealResponse = try await NetworkService.shared.post(
                endpoint: "/meals",
                body: mealRequest,
                requiresAuth: true
            )
            let mealResponse = response.toModel()
            
            print("Successfully posted meal with ID: \(mealResponse.id, default: "undefined")")
            dashboard.needsMacronutrientRefresh = true
            isLoading = false
            return true
        } catch {
            print("Error posting meal: \(error)")
            isLoading = false
            return false
        }
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
        
        if nutrition.foods.isEmpty {
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
