//
//  FoodRequest.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import Foundation

struct FoodRequest: Encodable {
    let foodTypeId: UUID
    let weight: Int
    let quantity: Int?
}
