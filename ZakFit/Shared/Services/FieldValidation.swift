//
//  FieldValidation.swift
//  ZakFit
//
//  Created by Anne Ferret on 26/11/2025.
//

import Foundation

final class FieldValidation {
    static let shared = FieldValidation()
    
    private init() {}
    
    func validateFirstName(_ firstName: String) -> ValidationResult {
        if firstName.isEmpty {
            return .failure("Le prénom ne peut pas être vide.")
        }
        return .success
    }
    
    func validateLastName(_ lastName: String) -> ValidationResult {
        if lastName.isEmpty {
            return .failure("Le nom de famille ne peut pas être vide.")
        }
        return .success
    }
    
    func validateEmail(_ email: String) -> ValidationResult {
        if email.isEmpty {
            return .failure("L'adresse e-mail ne peut pas être vide.")
        } else if !email.contains("@") || !email.contains(".") {
            return .failure("Le format de l'adresse email n'est pas valide.")
        }
        return .success
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        if password.isEmpty {
            return .failure("Le mot de passe ne peut pas être vide.")
        } else if password.count < 6 {
            return .failure("Le mot de passe doit faire au moins 6 caractères.")
        }
        return .success
    }
    
    func validateMatchingPasswords(_ password: String, _ confirmation: String) -> ValidationResult {
        if password != confirmation {
            return .failure("Les mots de passe ne correspondent pas.")
        }
        return .success
    }
}

enum ValidationResult {
    case success
    case failure(String)
    
    var isValid: Bool {
        if case .success = self {
            return true
        }
        return false
    }
    
    var errorMessage: String? {
        if case .failure(let message) = self {
            return message
        }
        return nil
    }
}
