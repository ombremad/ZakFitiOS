//
//  Untitled.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import Foundation

@Observable
class Exercise: Identifiable {
    let id: UUID
    let date: Date
    let length: Int
    let cals: Int
    let exerciseType: ExerciseType
    
    init(id: UUID, date: Date, length: Int, cals: Int, exerciseType: ExerciseType) {
        self.id = id
        self.date = date
        self.length = length
        self.cals = cals
        self.exerciseType = exerciseType
    }
}
