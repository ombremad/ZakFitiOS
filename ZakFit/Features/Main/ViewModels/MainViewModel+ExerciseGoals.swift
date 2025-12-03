//
//  MainViewModel+ExerciseGoals.swift
//  ZakFit
//
//  Created by Anne Ferret on 03/12/2025.
//

import Foundation

extension MainViewModel {
    
    func fetchExerciseGoals() async {
        isLoading = true
        
        do {
            let response: [GoalExerciseResponse] = try await NetworkService.shared.get(
                endpoint: "/goalExercises",
                requiresAuth: true
            )
            
            exerciseGoals.goals = response.map { $0.toModel() }
            print("Successfully fetched exercise goals")
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Une erreur est survenue: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func initNewExerciseGoal() async {
        exerciseGoals.selectedExerciseType = nil
        exerciseGoals.frequency = nil
        exerciseGoals.goalType = .none
        exerciseGoals.length = nil
        exerciseGoals.cals = nil

        if fitness.exerciseTypes.isEmpty {
            await fetchExerciseTypes()
        }
    }
    
    func sendNewExerciseGoal() async -> Bool {
        errorMessage = ""
        guard validateNewExerciseGoalForm() else { return false }
        
        isLoading = true
        
        let request = GoalExerciseRequest(
            frequency: exerciseGoals.frequency!,
            length: exerciseGoals.goalType == .length ? exerciseGoals.length! : nil,
            cals: exerciseGoals.goalType == .cals ? exerciseGoals.cals! : nil,
            exerciseTypeId: exerciseGoals.selectedExerciseType!.id
        )
        
        do {
            let response: GoalExerciseResponse = try await NetworkService.shared.post(
                endpoint: "/goalExercises",
                body: request,
                requiresAuth: true
            )
            
            print("Successfully posted new goal exercise with id \(response.id)")
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
    
    func deleteExerciseGoal(_ id: UUID) async -> Bool {
        errorMessage = ""
        isLoading = true
        
        do {
            try await NetworkService.shared.deleteNoResponse(
                endpoint: "/goalExercises/\(id.uuidString)",
                requiresAuth: true
            )
            print("Successfully deleted goal exercise.")
            
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
    
    // field validation
    
    func validateNewExerciseGoalForm() -> Bool {
        errorMessage = ""
        
        if exerciseGoals.selectedExerciseType == nil {
            errorMessage = "Veuillez sélectionner un exercice."
            return false
        }
        
        let frequencyResult = validation.validateFrequency(exerciseGoals.frequency)
        if !frequencyResult.isValid {
            errorMessage = frequencyResult.errorMessage ?? ""
            return false
        }
        
        if exerciseGoals.goalType == .cals {
            if let cals = exerciseGoals.cals {
                let calsResult = validation.validateCals(cals)
                if !calsResult.isValid {
                    errorMessage = frequencyResult.errorMessage ?? ""
                    return false
                }
            } else {
                errorMessage = "Veuillez indiquer un objectif en calories."
                return false
            }
        }
        
        if exerciseGoals.goalType == .length {
            if let length = exerciseGoals.length {
                let lengthResult = validation.validateLength(length)
                if !lengthResult.isValid {
                    errorMessage = lengthResult.errorMessage ?? ""
                    return false
                }
            } else {
                errorMessage = "Veuillez indiquer un objectif en minutes."
                return false
            }
        }
        
        return true
    }
}
