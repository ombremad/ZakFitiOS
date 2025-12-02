//
//  Meal.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

@Observable
class Meal: Identifiable {
    let id: UUID
    let date: Date
    let cals: Int
    let mealTypeName: String
    
    init(id: UUID, date: Date, cals: Int, mealTypeName: String) {
        self.id = id
        self.date = date
        self.cals = cals
        self.mealTypeName = mealTypeName
    }
}
