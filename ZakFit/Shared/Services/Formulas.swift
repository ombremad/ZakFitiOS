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
