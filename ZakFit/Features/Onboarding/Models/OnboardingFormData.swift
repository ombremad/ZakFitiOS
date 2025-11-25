//
//  OnboardingData.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import Foundation

struct OnboardingFormData: Equatable {
    var birthday: Date?
    var sex: Bool?
    var weight: Int?
    var height: Int?
    var restrictions: [RestrictionType] = []
}
