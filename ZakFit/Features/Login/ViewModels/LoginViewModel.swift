//
//  LoginViewModel.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import Foundation

@Observable
class LoginViewModel {
    var errorMessage: String = ""
    var isLoading: Bool = false
    
    func login(email: String, password: String) async {

        guard validateInputs(email: email, password: password) else {
            return
        }
        
        isLoading = true
        clearError()
        
        do {
            let loginRequest = LoginRequest(email: email, password: password)
            
            let response: LoginResponse = try await NetworkService.shared.post(
                endpoint: "/users/login",
                body: loginRequest,
                requiresAuth: false
            )
            
            // Save token and update auth state using shared instance
            try AuthManager.shared.markAsAuthenticated(token: response.token)
            print("Login successful for user \(email)")
            
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Une erreur est survenue: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func logout() {
        do {
            try AuthManager.shared.logout()
        } catch {
            print("Error logging out: \(error.localizedDescription)")
        }
    }
    
    // Field validations
    
    func validateEmail(_ email: String) -> Bool {
        return !email.isEmpty && email.contains("@")
    }
    
    func validatePassword(_ password: String) -> Bool {
        return !password.isEmpty
    }
    
    func validateInputs(email: String, password: String) -> Bool {
        if email.isEmpty || password.isEmpty {
            errorMessage = "Veuillez remplir tous les champs"
            return false
        }
        
        if !validateEmail(email) {
            errorMessage = "Adresse e-mail invalide"
            return false
        }
        
        return true
    }
    
    // Clear error when user starts typing
    func clearError() {
        errorMessage = ""
    }
}
