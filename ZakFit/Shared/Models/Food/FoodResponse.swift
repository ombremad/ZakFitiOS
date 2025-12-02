//
//  FoodResponse.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

struct FoodResponse: Codable {
    let id: UUID
    let weight: Int
    let quantity: Int?
    let foodType: FoodTypeResponse
    
    func toModel() -> Food {
        Food(
            id: id,
            weight: weight,
            quantity: quantity ?? nil,
            foodType: foodType.toModel()
        )
    }
}
