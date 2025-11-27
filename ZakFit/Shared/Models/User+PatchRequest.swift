//
//  UserUpdateRequest.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import Foundation

extension User {
    func changes(from original: User) -> User {
        let updates = User()
        
        if self.firstName != original.firstName {
            updates.firstName = self.firstName
        }
        
        if self.lastName != original.lastName {
            updates.lastName = self.lastName
        }
        
        if self.email != original.email {
            updates.email = self.email
        }
        
        if self.birthday != original.birthday {
            updates.birthday = self.birthday
        }
        
        if self.height != original.height {
            updates.height = self.height
        }
        
        if self.weight != original.weight {
            updates.weight = self.weight
        }
        
        if self.sex != original.sex {
            updates.sex = self.sex
        }
        
        if self.bmr != original.bmr {
            updates.bmr = self.bmr
        }
        
        if self.physicalActivity != original.physicalActivity {
            updates.physicalActivity = self.physicalActivity
        }
        
        if self.goalCals != original.goalCals {
            updates.goalCals = self.goalCals
        }
        
        if self.goalCarbs != original.goalCarbs {
            updates.goalCarbs = self.goalCarbs
        }
        
        if self.goalFats != original.goalFats {
            updates.goalFats = self.goalFats
        }
        
        if self.goalProts != original.goalProts {
            updates.goalProts = self.goalProts
        }
        
        return updates
    }
    
    func hasChanges(from original: User) -> Bool {
        return firstName != original.firstName ||
               lastName != original.lastName ||
               email != original.email ||
               birthday != original.birthday ||
               height != original.height ||
               weight != original.weight ||
               sex != original.sex ||
               bmr != original.bmr ||
               physicalActivity != original.physicalActivity ||
               goalCals != original.goalCals ||
               goalCarbs != original.goalCarbs ||
               goalFats != original.goalFats ||
               goalProts != original.goalProts
    }
}
