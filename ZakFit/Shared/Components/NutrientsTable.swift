//
//  NutrientsTable.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct NutrientsTable: View {
    var title: String? = nil
    let cals: Int
    let carbs: Int
    let fats: Int
    let prots: Int
        
    var body: some View {
        HStack(alignment: .bottom, spacing: 24) {
            VStack(alignment: .leading) {
                    if let title {
                        Text(title)
                            .font(.cardBigTitle)
                    }
                    
                    HStack(alignment: .bottom, spacing: 5) {
                        Text(cals.description)
                            .font(.cardDataSmall)
                        Text("kcal")
                            .font(.cardUnit)
                            .foregroundStyle(Color.Label.tertiary)
                            .offset(y: -3)
                    }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("dont")
                        .font(.cardUnit)
                        .foregroundStyle(Color.Label.tertiary)
                    NutrientRow(
                        name: "Glucides",
                        color: Color.Chart.carbs,
                        value: carbs,
                        cals: cals
                    )
                    NutrientRow(
                        name: "Lipides",
                        color: Color.Chart.fats,
                        value: fats,
                        cals: cals
                    )
                    NutrientRow(
                        name: "Protéines",
                        color: Color.Chart.prots,
                        value: prots,
                        cals: cals
                    )
                }
                .font(.cardCaption)
            }
            NutrientsDonutChart(carbs: carbs, fats: fats, prots: prots)
                .frame(width: 100, height: 100)
        }
        .foregroundStyle(Color.Label.secondary)
        .lineLimit(1)
        .padding()
        .glassEffect(.regular.tint(title == nil ? .clear : Color.Card.darkBackground), in: .rect(cornerRadius: 25))
        .contentShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    NutrientsTable(
        title: "Muesli",
        cals: 189,
        carbs: 128,
        fats: 30,
        prots: 22
    )
}
