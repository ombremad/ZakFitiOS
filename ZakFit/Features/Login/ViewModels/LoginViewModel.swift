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
    
    var formState: FormState = .login
    enum FormState { case login, signup }
    
    var isLoading: Bool = false
        
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
    
    // Onboarding flow
    var showOnboarding: Bool = false
    var currentTab: Int = 0
    var restrictionTypesAvailable: [RestrictionType] = []

    func fetchRestrictionTypes() async {
        isLoading = true
        
        do {
            let response: [RestrictionTypeResponse] = try await NetworkService.shared.get(
                endpoint: "/restrictionTypes",
                requiresAuth: false
            )
            restrictionTypesAvailable = response.map(RestrictionType.init)
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Une erreur est survenue: \(error.localizedDescription)"
        }
                
        isLoading = false
    }
    
    // Field validators
    
    func validateForm(_ formData: LoginFormData) -> Bool {
        errorMessage = ""
        
        if formState == .signup {
            guard validateFirstName(formData.firstName) &&
                    validateLastName(formData.lastName) else {
                return false
            }
        }
        
        guard validateEmail(formData.email) && validatePassword(formData.password) else {
            return false
        }
        
        if formState == .signup {
            guard validateMatchingPasswords(formData.password, formData.passwordConfirmation) else {
                return false
            }
        }
        
        return true
    }
    
    func validateFirstName(_ firstName: String) -> Bool {
        if firstName.isEmpty {
            errorMessage = "Le prénom ne peut pas être vide."
            return false
        } else {
            return true
        }
    }
    
    func validateLastName(_ lastName: String) -> Bool {
        if lastName.isEmpty {
            errorMessage = "Le nom de famille ne peut pas être vide."
            return false
        } else {
            return true
        }
    }
    
    func validateEmail(_ email: String) -> Bool {
        if email.isEmpty {
            errorMessage = "L'adresse e-mail ne peut pas être vide."
            return false
        } else if !email.contains("@") || !email.contains(".") {
            errorMessage = "Le format de l'adresse email n'est pas valide."
            return false
        } else {
            return true
        }
    }
    
    func validatePassword(_ password: String) -> Bool {
        if password.isEmpty {
            errorMessage = "Le mot de passe ne peut pas être vide."
            return false
        } else if password.count < 6 {
            errorMessage = "Le mot de passe doit faire au moins 6 caractères."
            return false
        } else {
            return true
        }
    }
    
    func validateMatchingPasswords(_ password: String, _ passwordConfirmation: String) -> Bool {
        if password != passwordConfirmation {
            errorMessage = "Les mots de passe ne correspondent pas."
            return false
        } else {
            return true
        }
    }
}
