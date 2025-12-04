//
//  NutrientIntakeRow.swift
//  ZakFit
//
//  Created by Anne Ferret on 04/12/2025.
//

import SwiftUI

struct NutrientIntakeRow: View {
    let name: String
    let amount: Int
    let total: Int
    let color: Color

    var body: some View {
        HStack(spacing: 42) {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.cardTitle)
                HStack(alignment: .bottom, spacing: 4) {
                    Text(calculatePercentage(from: amount, relativeTo: total).description)
                        .font(.cardDataSmall)
                    Text("%")
                        .font(.cardUnit)
                        .foregroundStyle(Color.Label.tertiary)
                        .offset(y: -3)
                }
            }
            .frame(width: 70, alignment: .leading)
            NutrientStackedBars(amount: amount, total: total, color: color)
        }
        .foregroundStyle(Color.Label.secondary)
    }
}
