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

    // dashboard values
    var user = User()
    var calsToday: Int?
    
    // fitness values
    var exercises: [Exercise] = []
    var exerciseTypes: [ExerciseType] = []
    
    // nutrition values
    var foodTypes: [FoodType] = []
    var meals: [MealSmall] = []
    var meal: Meal = Meal()
    var mealTypes: [MealType] = []
    var foods: [Food] = []
    var shouldNavigateToFoodSelection: Bool = false
}
