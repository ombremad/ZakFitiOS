//
//  ExerciseRequest.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import Foundation

struct ExerciseRequest: Encodable {
    let date: Date
    let length: Int
    let cals: Int
    let exerciseTypeId: UUID    
}
