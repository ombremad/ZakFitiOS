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
    
    func validateFirstName(_ firstName: String?) -> ValidationResult {
        if let firstName = firstName {
            if firstName.isEmpty {
                return .failure("Le prénom ne peut pas être vide.")
            }
            return .success
        }
        return .failure("Le prénom est obligatoire.")
    }
    
    func validateLastName(_ lastName: String?) -> ValidationResult {
        if let lastName = lastName {
            if lastName.isEmpty {
                return .failure("Le nom de famille ne peut pas être vide.")
            }
            return .success
        }
        return .failure("Le nom de famille est obligatoire.")
    }
    
    func validateEmail(_ email: String?) -> ValidationResult {
        if let email = email {
            if email.isEmpty {
                return .failure("L'adresse e-mail ne peut pas être vide.")
            } else if !email.contains("@") || !email.contains(".") {
                return .failure("Le format de l'adresse email n'est pas valide.")
            }
            return .success
        }
        return .failure("L'adresse e-mail est obligatoire.")
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
    
    func validateBirthday(_ date: Date?) -> ValidationResult {
        if let date = date {
            let calendar = Calendar.current
            let today = Date()
            let ageComponents = calendar.dateComponents([.year], from: date, to: today)
            
            if let age = ageComponents.year, age > 120 {
                return .failure("Vous devez entrer une date de naissance raisonnable.")
            } else if let age = ageComponents.year, age < 14 {
                return .failure("Vous devez avoir au moins 14 ans pour vous inscrire.")
            }
            return .success
        }
        return .failure("La date de naissance est obligatoire.")
    }
    
    func validateSex(_ sex: Bool?) -> ValidationResult {
        if sex != nil {
            return .success
        }
        return .failure("Le sexe est obligatoire.")
    }
    
    func validateHeight(_ height: Int?) -> ValidationResult {
        if let height = height {
            if height < 80 || height > 260 {
                return .failure("La taille doit être raisonnable.")
            }
            return .success
        }
        return .failure("La taille est obligatoire.")
    }
    
    func validateWeight(_ weight: Int?) -> ValidationResult {
        if let weight = weight {
            if weight < 20 || weight > 200 {
                return .failure("Le poids doit être raisonnable.")
            }
            return .success
        }
        return .failure("Le poids est obligatoire.")
    }
    
    func validateCalories(_ dailyCals: Int) -> ValidationResult {
        if dailyCals < 50 || dailyCals > 9000 {
            return .failure("Le nombre de calories par jour doit être réaliste.")
        }
        return .success
    }
    
    func validatePhysicalActivity(_ physicalActivity: Int?) -> ValidationResult {
        if let physicalActivity = physicalActivity {
            if physicalActivity < 0 || physicalActivity > 5 {
                return .failure("Erreur : le niveau d'activité est incorrect.")
            }
            return .success
        }
        return .failure("Veuillez choisir un niveau d'activité.")
    }
    
    func validatePercentage(_ percentage: Int) -> ValidationResult {
        if percentage != 100 {
            return .failure("Vérifiez que le pourcentage total équivaut à 100 %.")
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
