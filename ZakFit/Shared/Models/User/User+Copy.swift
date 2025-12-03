//
//  User+Copy.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

extension User {
    func copy() -> User {
        return User(
            id: self.id,
            firstName: self.firstName,
            lastName: self.lastName,
            email: self.email,
            birthday: self.birthday,
            height: self.height,
            weight: self.weight,
            sex: self.sex,
            bmr: self.bmr,
            physicalActivity: self.physicalActivity,
            goalCals: self.goalCals,
            goalCarbs: self.goalCarbs,
            goalFats: self.goalFats,
            goalProts: self.goalProts,
            restrictionTypes: self.restrictionTypes
        )
    }
}
