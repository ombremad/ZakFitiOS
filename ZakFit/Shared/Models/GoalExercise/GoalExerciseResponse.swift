//
//  GoalExerciseResponse.swift
//  ZakFit
//
//  Created by Anne Ferret on 03/12/2025.
//

import Foundation

struct GoalExerciseResponse: Codable {
    let id: UUID
    let frequency: Int
    let length: Int?
    let cals: Int?
    let exerciseType: ExerciseTypeResponse
    
    func toModel() -> GoalExercise {
        GoalExercise(
            id: id,
            frequency: frequency,
            length: length ?? nil,
            cals: cals ?? nil,
            exerciseType: exerciseType.toModel()
        )
    }
}
