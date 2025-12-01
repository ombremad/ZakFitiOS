//
//  ExerciseType.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import Foundation

@Observable
class ExerciseType: Identifiable {
    let id: UUID
    let name: String
    let icon: String
    let level: Int
    let calsPerMinute: Int
    
    init(id: UUID?, name: String, icon: String, level: Int, calsPerMinute: Int) {
        self.id = id ?? UUID()
        self.name = name
        self.icon = icon
        self.level = level
        self.calsPerMinute = calsPerMinute
    }
}
