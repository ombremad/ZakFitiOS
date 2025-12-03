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
        var restrictionTypes: [RestrictionType] = []
        var meals: [MealSmall] = []
        var meal: Meal = Meal()
        var mealTypes: [MealType] = []
        var foods: [Food] = []
        var shouldNavigateToFoodSelection: Bool = false
    }
    
    // nutrition goals values
    var nutritionGoals = NutritionGoals()
    struct NutritionGoals {
        var bmr: Int = 0
        var carbsPercentage: Int = 0
        var fatsPercentage: Int = 0
        var protsPercentage: Int = 0
        var calsDaily: Int = 0
        var carbsDaily: Int = 0
        var fatsDaily: Int = 0
        var protsDaily: Int = 0
        var values: Int {
            bmr + calsDaily + carbsPercentage + fatsPercentage + protsPercentage
        }
        var fitnessProgram: FitnessProgram = .custom
    }
    
    // exercise goals values
    var exerciseGoals = ExerciseGoals()
    struct ExerciseGoals {
        var goals: [GoalExercise] = []
        var selectedExerciseType: ExerciseType? = nil
        var frequency: Int? = nil
        var goalType: GoalType = .none
        var length: Int? = nil
        var cals: Int? = nil
    }
}
