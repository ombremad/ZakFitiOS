//
//  AuthManager.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import Foundation

@Observable
class AuthManager {
    static let shared = AuthManager()

    var isAuthenticated: Bool = false
    
    init() {
        checkAuthentication()
    }
    
    func checkAuthentication() {
        isAuthenticated = KeychainManager.shared.hasToken()
    }
    
    func markAsAuthenticated(token: String) throws {
        try KeychainManager.shared.saveToken(token)
        isAuthenticated = true
    }
    
    func logout() throws {
        try KeychainManager.shared.deleteToken()
        isAuthenticated = false
    }
}
