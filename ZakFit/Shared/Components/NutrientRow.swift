//
//  NutrientRow.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct NutrientRow: View {
    let name: String
    let color: Color
    let value: Int
    let cals: Int
    
    var body: some View {
        HStack {
            let percentage = calculatePercentage(from: value, relativeTo: cals)
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            Text(name)
                .frame(width: 80, alignment: .leading)
            Text("\(percentage) %")
                .frame(width: 30, alignment: .trailing)
            Spacer()
            Text("\(value) kcal")
                .frame(width: 60, alignment: .trailing)
        }
    }
}
