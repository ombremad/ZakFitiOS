//
//  RestrictionType.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import Foundation

@Observable
class RestrictionType: Identifiable, Equatable {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from response: RestrictionTypeResponse) {
        self.id = response.id
        self.name = response.name
    }
    
    static func == (lhs: RestrictionType, rhs: RestrictionType) -> Bool {
            lhs.id == rhs.id && lhs.name == rhs.name
        }
}
