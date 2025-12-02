//
//  User.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import Foundation

// MARK: - Domain Model
@Observable
final class User {
    var id: UUID?
    var firstName: String?
    var lastName: String?
    var email: String?
    var birthday: Date?
    var height: Int?
    var weight: Int?
    var sex: Bool?
    var bmr: Int?
    var physicalActivity: Int?
    var goalCals: Int?
    var goalCarbs: Int?
    var goalFats: Int?
    var goalProts: Int?
    var restrictionTypes: [RestrictionType]?
    
    init(
        id: UUID? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        email: String? = nil,
        birthday: Date? = nil,
        height: Int? = nil,
        weight: Int? = nil,
        sex: Bool? = nil,
        bmr: Int? = nil,
        physicalActivity: Int? = nil,
        goalCals: Int? = nil,
        goalCarbs: Int? = nil,
        goalFats: Int? = nil,
        goalProts: Int? = nil,
        restrictionTypes: [RestrictionType]? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.birthday = birthday
        self.height = height
        self.weight = weight
        self.sex = sex
        self.bmr = bmr
        self.physicalActivity = physicalActivity
        self.goalCals = goalCals
        self.goalCarbs = goalCarbs
        self.goalFats = goalFats
        self.goalProts = goalProts
        self.restrictionTypes = restrictionTypes
    }
    
    // Convenience initializer from API response
    convenience init(from response: UserResponse) {
        self.init(
            id: response.id,
            firstName: response.firstName,
            lastName: response.lastName,
            email: response.email,
            birthday: response.birthday,
            height: response.height,
            weight: response.weight,
            sex: response.sex,
            bmr: response.bmr,
            physicalActivity: response.physicalActivity,
            goalCals: response.goalCals,
            goalCarbs: response.goalCarbs,
            goalFats: response.goalFats,
            goalProts: response.goalProts,
            restrictionTypes: response.restrictionTypes?.map { RestrictionType(from: $0) }
        )
    }
    
    // Convert to API request
    func toRequest() -> UserRequest {
        UserRequest(
            firstName: firstName,
            lastName: lastName,
            email: email,
            birthday: birthday,
            height: height,
            weight: weight,
            sex: sex,
            bmr: bmr,
            physicalActivity: physicalActivity,
            goalCals: goalCals,
            goalCarbs: goalCarbs,
            goalFats: goalFats,
            goalProts: goalProts
        )
    }
}
