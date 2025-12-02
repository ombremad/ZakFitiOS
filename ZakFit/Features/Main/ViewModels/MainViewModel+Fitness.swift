//
//  MainViewModel+Fitness.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import Foundation

extension MainViewModel {
    func fetchExercises(exerciseType: UUID? = nil, minLength: Int? = nil, maxLength: Int? = nil, days: Int? = nil, sortBy: String? = nil, sortOrder: String? = nil) async {
        isLoading = true
        do {
            var queryParams: [String] = []
            
            if let days = days {
                queryParams.append("days=\(days)")
            }
            if let exerciseType = exerciseType {
                queryParams.append("exerciseType=\(exerciseType.uuidString)")
            }
            if let minLength = minLength {
                queryParams.append("minLength=\(minLength)")
            }
            if let maxLength = maxLength {
                queryParams.append("maxLength=\(maxLength)")
            }
            
            if let sortBy = sortBy {
                queryParams.append("sortBy=\(sortBy)")
            }
            
            if let sortOrder = sortOrder {
                queryParams.append("sortOrder=\(sortOrder)")
            }
            
            let endpoint = if queryParams.isEmpty {
                "/exercises"
            } else {
                "/exercises?\(queryParams.joined(separator: "&"))"
            }
            
            let response: [ExerciseResponse] = try await NetworkService.shared.get(
                endpoint: endpoint,
                requiresAuth: true
            )
            
            exercises = response.map { $0.toModel() }
        } catch {
            print("Error fetching activities: \(error)")
        }
        isLoading = false
    }
    
    func sendNewExercise(exerciseType: ExerciseType?, length: Int?, cals: Int?) async -> Bool {
        guard validateExerciseForm(exerciseType: exerciseType, length: length, cals: cals) else { return false }
        guard await postNewExercise(exerciseType: exerciseType, length: length, cals: cals) else { return false }
        return true
    }
    
    func postNewExercise(exerciseType: ExerciseType?, length: Int?, cals: Int?) async -> Bool {
        errorMessage = ""
        isLoading = true
        do {
            let request = ExerciseRequest(
                date: .now,
                length: length!,
                cals: cals!,
                exerciseTypeId: exerciseType!.id
            )
            
            let response: ExerciseResponse = try await NetworkService.shared.post(
                endpoint: "/exercises",
                body: request,
                requiresAuth: true
            )
            
            print("Successfully posted new activity with id \(response.id)")
            isLoading = false
            return true
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        } catch {
            errorMessage = "Une erreur est survenue: \(error.localizedDescription)"
            isLoading = false
            return false
        }
    }
    
    // Field validation
    func validateExerciseForm(exerciseType: ExerciseType?, length: Int?, cals: Int?) -> Bool {
        errorMessage = ""
        
        if exerciseType == nil {
            errorMessage = "Il est obligatoire de choisir un type d'exercice"
            return false
        }
        
        if let length = length {
            let lengthResult = validation.validateLength(length)
            if !lengthResult.isValid {
                errorMessage = lengthResult.errorMessage ?? ""
                return false
            }
        } else {
            errorMessage = "Il est obligatoire de rentrer une durée."
            return false
        }
        
        if let cals = cals {
            let calsResult = validation.validateCals(cals)
            if !calsResult.isValid {
                errorMessage = calsResult.errorMessage ?? ""
                return false
            }
        } else {
            errorMessage = "Il est obligatoire de rentrer le nombre de calories."
            return false
        }
                
        return true
    }
}
