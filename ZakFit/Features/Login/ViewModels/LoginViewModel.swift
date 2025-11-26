//
//  LoginViewModel.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import Foundation

@Observable
class LoginViewModel {
    private let validation = FieldValidation.shared
    
    var isLoading: Bool = false
    var errorMessage: String = ""
    
    var formState: FormState = .login
    enum FormState { case login, signup }
    var showOnboarding: Bool = false
        
    // Main login functions
    
    func login(formData: LoginFormData) async {
        isLoading = true

        guard validateForm(formData) else {
            isLoading = false
            return
        }
        
        do {
            let loginRequest = LoginRequest(email: formData.email, password: formData.password)
            
            let response: LoginResponse = try await NetworkService.shared.post(
                endpoint: "/users/login",
                body: loginRequest,
                requiresAuth: false
            )
            
            // Save token and update auth state using shared instance
            try AuthManager.shared.markAsAuthenticated(token: response.token)
            print("Login successful for user \(formData.email)")
            
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Une erreur est survenue: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func signup(formData: LoginFormData) async {
        isLoading = true
        
        guard validateForm(formData) else {
            isLoading = false
            return
        }
        
        isLoading = false
        showOnboarding = true
    }
    
    func logout() {
        do {
            try AuthManager.shared.logout()
            print("User logged out successfully")
        } catch {
            print("Error logging out: \(error.localizedDescription)")
        }
    }
    
    // Field validation
    
    func validateForm(_ formData: LoginFormData) -> Bool {
        errorMessage = ""
        
        if formState == .signup {
            let firstNameResult = validation.validateFirstName(formData.firstName)
            if !firstNameResult.isValid {
                errorMessage = firstNameResult.errorMessage ?? ""
                return false
            }
            
            let lastNameResult = validation.validateLastName(formData.lastName)
            if !lastNameResult.isValid {
                errorMessage = lastNameResult.errorMessage ?? ""
                return false
            }
        }
        
        let emailResult = validation.validateEmail(formData.email)
        if !emailResult.isValid {
            errorMessage = emailResult.errorMessage ?? ""
            return false
        }
        
        let passwordResult = validation.validatePassword(formData.password)
        if !passwordResult.isValid {
            errorMessage = passwordResult.errorMessage ?? ""
            return false
        }
        
        if formState == .signup {
            let matchResult = validation.validateMatchingPasswords(
                formData.password,
                formData.passwordConfirmation
            )
            if !matchResult.isValid {
                errorMessage = matchResult.errorMessage ?? ""
                return false
            }
        }
        
        return true
    }
}
