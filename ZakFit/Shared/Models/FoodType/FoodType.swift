//
//  FoodType.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

@Observable
class FoodType: Identifiable {
    let id: UUID
    let name: String
    let calsRatio: Int
    let carbsRatio: Int
    let fatsRatio: Int
    let protsRatio: Int
    let weightPerServing: Int?
    
    init(
        id: UUID,
        name: String,
        calsRatio: Int,
        carbsRatio: Int,
        fatsRatio: Int,
        protsRatio: Int,
        weightPerServing: Int?
    ) {
        self.id = id
        self.name = name
        self.calsRatio = calsRatio
        self.carbsRatio = carbsRatio
        self.fatsRatio = fatsRatio
        self.protsRatio = protsRatio
        self.weightPerServing = weightPerServing ?? nil
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FoodType, rhs: FoodType) -> Bool {
        lhs.id == rhs.id
    }
}
