//
//  GoalExerciseRequest.swift
//  ZakFit
//
//  Created by Anne Ferret on 03/12/2025.
//

import Foundation

struct GoalExerciseRequest: Encodable {
    let frequency: Int
    let length: Int?
    let cals: Int?
    let exerciseTypeId: UUID
}
