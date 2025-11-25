//
//  OnboardingData.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import Foundation

struct OnboardingFormData: Equatable {
    var birthday: Date = .now
    var sex: Bool = false
    var weight: Int = 0
    var height: Int = 0
    var restrictions: [RestrictionType] = []
}
