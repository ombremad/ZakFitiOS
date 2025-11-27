//
//  SignupRequest.swift
//  ZakFit
//
//  Created by Anne Ferret on 26/11/2025.
//

import Foundation

struct SignupRequest: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let birthday: Date
    let height: Int
    let weight: Int
    let sex: Bool
    let bmr: Int
    let physicalActivity: Int
    let goalCals: Int
    let goalCarbs: Int
    let goalFats: Int
    let goalProts: Int
    let restrictionTypeIds: [UUID]
}
