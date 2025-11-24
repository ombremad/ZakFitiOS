//
//  ErrorResponse.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import Foundation

struct ErrorResponse: Codable {
    let error: Bool
    let reason: String
}
