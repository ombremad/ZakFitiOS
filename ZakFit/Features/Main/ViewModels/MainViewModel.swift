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

    var isLoading: Bool = false
    var errorMessage: String = ""

    var user = User()
}
