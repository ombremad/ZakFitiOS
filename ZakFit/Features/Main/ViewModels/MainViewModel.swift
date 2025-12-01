//
//  MainViewModel.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import Foundation

@Observable
class MainViewModel {
    let validation = FieldValidation.shared

    // system
    var selectedTab: AppTab = .dashboard
    var isLoading: Bool = false
    var errorMessage: String = ""

    // dashboard values
    var user = User()
    var calsToday: Int?
    
    // fitness values
    var exercises: [Exercise] = []
    var exerciseTypes: [ExerciseType] = []
}
