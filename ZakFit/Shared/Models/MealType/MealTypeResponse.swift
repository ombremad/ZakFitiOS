//
//  MealTypeResponse.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

struct MealTypeResponse: Codable {
    let id: UUID
    let name: String
    
    func toModel() -> MealType {
        MealType(
            id: id,
            name: name
        )
    }
}
