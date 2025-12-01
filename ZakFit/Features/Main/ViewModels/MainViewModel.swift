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
    var isLoading: Bool = false
    var errorMessage: String = ""

    // values
    var user = User()
    var calsToday: Int?
}
