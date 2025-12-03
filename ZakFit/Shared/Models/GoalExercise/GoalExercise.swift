//
//  GoalExercise.swift
//  ZakFit
//
//  Created by Anne Ferret on 03/12/2025.
//

import Foundation

@Observable
class GoalExercise: Identifiable {
    let id: UUID
    let frequency: Int
    let length: Int?
    let cals: Int?
    let exerciseType: ExerciseType
    
    init(
        id: UUID,
        frequency: Int,
        length: Int? = nil,
        cals: Int? = nil,
        exerciseType: ExerciseType
    ) {
        self.id = id
        self.frequency = frequency
        self.length = length
        self.cals = cals
        self.exerciseType = exerciseType
    }
}
