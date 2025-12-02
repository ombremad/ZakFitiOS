//
//  FoodTypeResponse.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

struct FoodTypeResponse: Codable {
    let id: UUID
    let name: String
    let calsRatio: Int?
    let carbsRatio: Int?
    let fatsRatio: Int?
    let protsRatio: Int?
    let weightPerServing: Int?
    
    func toModel() -> FoodType {
        FoodType(
            id: id,
            name: name,
            calsRatio: calsRatio ?? 0,
            carbsRatio: carbsRatio ?? 0,
            fatsRatio: fatsRatio ?? 0,
            protsRatio: protsRatio ?? 0,
            weightPerServing: weightPerServing ?? nil
        )
    }
}
