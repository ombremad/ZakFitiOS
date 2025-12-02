//
//  MealListItemResponse.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import Foundation

struct MealListItemResponse: Codable {
    let id: UUID
    let date: Date
    let cals: Int
    let mealTypeName: String
    
    func toModel() -> Meal {
        Meal(
            id: id,
            date: date,
            cals: cals,
            mealTypeName: mealTypeName
        )
    }
}
