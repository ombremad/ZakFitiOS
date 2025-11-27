//
//  User.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import Foundation

@Observable
final class User: Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case height
        case weight
        case birthday
        case sex
        case physicalActivity = "physical_activity"
        case bmr
        case goalCals = "goal_cals"
        case goalProts = "goal_prots"
        case goalCarbs = "goal_carbs"
        case goalFats = "goal_fats"
    }
    
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
        goalProts: Int? = nil
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
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        birthday = try container.decodeIfPresent(Date.self, forKey: .birthday)
        height = try container.decodeIfPresent(Int.self, forKey: .height)
        weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        sex = try container.decodeIfPresent(Bool.self, forKey: .sex)
        bmr = try container.decodeIfPresent(Int.self, forKey: .bmr)
        physicalActivity = try container.decodeIfPresent(Int.self, forKey: .physicalActivity)
        goalCals = try container.decodeIfPresent(Int.self, forKey: .goalCals)
        goalCarbs = try container.decodeIfPresent(Int.self, forKey: .goalCarbs)
        goalFats = try container.decodeIfPresent(Int.self, forKey: .goalFats)
        goalProts = try container.decodeIfPresent(Int.self, forKey: .goalProts)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(birthday, forKey: .birthday)
        try container.encodeIfPresent(height, forKey: .height)
        try container.encodeIfPresent(weight, forKey: .weight)
        try container.encodeIfPresent(sex, forKey: .sex)
        try container.encodeIfPresent(bmr, forKey: .bmr)
        try container.encodeIfPresent(physicalActivity, forKey: .physicalActivity)
        try container.encodeIfPresent(goalCals, forKey: .goalCals)
        try container.encodeIfPresent(goalCarbs, forKey: .goalCarbs)
        try container.encodeIfPresent(goalFats, forKey: .goalFats)
        try container.encodeIfPresent(goalProts, forKey: .goalProts)
    }
}
