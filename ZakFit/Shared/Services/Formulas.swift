//
//  Formulas.swift
//  ZakFit
//
//  Created by Anne Ferret on 26/11/2025.
//

import Foundation

func calculateBMR(birthday: Date, sex: Bool, height: Int, weight: Int) -> Int {
    // Get age
    let calendar = Calendar.current
    let today = Date()
    let ageComponents = calendar.dateComponents([.year], from: birthday, to: today)
    if let age = ageComponents.year {
        
        // Implement Mifflin-St Jeor equation
        let s: Double = sex ? 5.0 : -161.0
        let weightComponent = 10.0 * Double(weight)
        let heightComponent = 6.25 * Double(height)
        let ageComponent = 5.0 * Double(age)
        let bmr = weightComponent + heightComponent - ageComponent + s
        return Int(bmr)
    }
    return 0
}

func calculateDailyCals(bmr: Int, physicalActivity: Int) -> Int {
    var multiplier: Int
    switch physicalActivity {
        case 0: multiplier = 20
        case 1: multiplier = 30
        case 2: multiplier = 45
        case 3: multiplier = 55
        case 4: multiplier = 70
        case 5: multiplier = 90
        default: multiplier = 0
    }
    return bmr + (bmr * multiplier / 100)
}

func getNutrientPercentages(fitnessProgram: FitnessProgram) -> (carbsPercentage: Int, fatsPercentage: Int, protsPercentage: Int) {
    switch fitnessProgram {
        case .gainMass:
            return (
                carbsPercentage: 45,
                fatsPercentage: 15,
                protsPercentage: 40
            )
        case .loseWeight:
            return (
                carbsPercentage: 30,
                fatsPercentage: 25,
                protsPercentage: 45
            )
        default:
            return (
                carbsPercentage: 40,
                fatsPercentage: 30,
                protsPercentage: 30
            )
    }
}

func calculatePercentage(from: Int, relativeTo: Int) -> Int {
    guard relativeTo > 0 else { return 0 }
    return Int(Double(from) / Double(relativeTo) * 100)
}
