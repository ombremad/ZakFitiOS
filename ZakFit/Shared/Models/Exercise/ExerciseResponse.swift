//
//  ExerciseResponse.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import Foundation

struct ExerciseResponse: Codable {
    let id: UUID
    let date: Date
    let length: Int
    let cals: Int
    let exerciseType: ExerciseTypeResponse
    
    func toModel() -> Exercise {
        Exercise(
            id: id,
            date: date,
            length: length,
            cals: cals,
            exerciseType: exerciseType.toModel()
        )
    }
}
