//
//  MealResponse.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

struct MealResponse: Codable {
    let id: UUID
    let date: Date
    let cals: Int
    let mealType: MealTypeResponse
    let foods: [FoodResponse]
    
    func toModel() -> Meal {
        Meal(
            id: id,
            date: date,
            cals: cals,
            mealType: mealType.toModel(),
            foods: foods.map { $0.toModel() }
        )
    }
}
