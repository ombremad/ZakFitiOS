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
    let carbs: Int
    let fats: Int
    let prots: Int
    let mealTypeName: String
    
    func toSmallModel() -> MealSmall {
        MealSmall(
            id: id,
            date: date,
            cals: cals,
            carbs: carbs,
            fats: fats,
            prots: prots,
            mealTypeName: mealTypeName
        )
    }
}
