//
//  MealSmall.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

@Observable
class MealSmall: Identifiable {
    let id: UUID
    let date: Date
    let cals: Int
    let carbs: Int
    let fats: Int
    let prots: Int
    let mealTypeName: String
    
    init(id: UUID, date: Date, cals: Int, carbs: Int, fats: Int, prots: Int, mealTypeName: String) {
        self.id = id
        self.date = date
        self.cals = cals
        self.carbs = carbs
        self.fats = fats
        self.prots = prots
        self.mealTypeName = mealTypeName
    }
}
