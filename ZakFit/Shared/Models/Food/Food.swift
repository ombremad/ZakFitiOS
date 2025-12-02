//
//  Food.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

@Observable
class Food: Identifiable {
    let id: UUID
    let weight: Int
    let quantity: Int?
    let foodType: FoodType
    
    init(
        id: UUID,
        weight: Int,
        quantity: Int?,
        foodType: FoodType
    ) {
        self.id = id
        self.weight = weight
        self.quantity = quantity ?? nil
        self.foodType = foodType
    }
}
