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
    
    var cals: Int {
        Int(Double(weight) / 100.0 * Double(foodType.calsRatio))
    }
    
    var carbs: Int {
        Int(Double(weight) / 100.0 * Double(foodType.carbsRatio))
    }
    
    var fats: Int {
        Int(Double(weight) / 100.0 * Double(foodType.fatsRatio))
    }
    
    var prots: Int {
        Int(Double(weight) / 100.0 * Double(foodType.protsRatio))
    }
    
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
    
    // Convert to API request
    func toRequest() -> FoodRequest {
        FoodRequest(foodTypeId: foodType.id, weight: weight, quantity: quantity)
    }

}
