//
//  Meal.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

@Observable
class Meal: Identifiable {
    let id: UUID?
    let date: Date?
    let cals: Int?
    let carbs: Int?
    let fats: Int?
    let prots: Int?
    let mealType: MealType?
    let foods: [Food]?
    
    init(
        id: UUID? = nil,
        date: Date? = nil,
        cals: Int? = nil,
        carbs: Int? = nil,
        fats: Int? = nil,
        prots: Int? = nil,
        mealType: MealType? = nil,
        foods: [Food]? = nil
    ) {
        self.id = id
        self.date = date
        self.cals = cals
        self.carbs = carbs
        self.fats = fats
        self.prots = prots
        self.mealType = mealType
        self.foods = foods
    }
}
