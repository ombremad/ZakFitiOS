//
//  ExerciseTypeResponse.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import Foundation

struct ExerciseTypeResponse: Codable {
    let id: UUID
    let name: String
    let icon: String
    let level: Int
    let calsPerMinute: Int
    
    func toModel() -> ExerciseType {
        ExerciseType(
            id: id,
            name: name,
            icon: icon,
            level: level,
            calsPerMinute: calsPerMinute
        )
    }
}
