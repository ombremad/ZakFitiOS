//
//  MealRequest.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

struct MealRequest: Encodable {
    let date: Date
    let cals: Int
    let carbs: Int
    let fats: Int
    let prots: Int
    let mealTypeId: UUID
    let foods: [FoodRequest]
}
