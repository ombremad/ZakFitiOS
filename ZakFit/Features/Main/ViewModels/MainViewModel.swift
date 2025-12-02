//
//  MainViewModel.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import Foundation

@Observable
class MainViewModel {
    // system
    let validation = FieldValidation.shared
    var selectedTab: AppTab = .dashboard
    var isLoading: Bool = false
    var errorMessage: String = ""
    var user = User()

    // dashboard values
    var dashboard = Dashboard()
    struct Dashboard {
        var calsToday: Int?
        var carbsToday: Int?
        var fatsToday: Int?
        var protsToday: Int?
        var needsUserRefresh: Bool = false
        var needsMacronutrientRefresh: Bool = false
    }
        
    // fitness values
    var fitness = Fitness()
    struct Fitness {
        var exercises: [Exercise] = []
        var exerciseTypes: [ExerciseType] = []
    }
    
    // nutrition values
    var nutrition = Nutrition()
    struct Nutrition {
        var foodTypes: [FoodType] = []
        var meals: [MealSmall] = []
        var meal: Meal = Meal()
        var mealTypes: [MealType] = []
        var foods: [Food] = []
        var shouldNavigateToFoodSelection: Bool = false
    }
}
