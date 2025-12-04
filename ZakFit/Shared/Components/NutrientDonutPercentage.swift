//
//  NutrientDonutPercentage.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI
import Charts

struct NutrientDonutPercentage: View {
    let amount: Int
    let total: Int
    var gradient: LinearGradient? = nil
    var color: Color? = nil
    let title: String
    var isMini: Bool = false
        
    private var remaining: Int {
        max(0, total - amount)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Chart {
                SectorMark(
                    angle: .value("Amount", amount),
                    innerRadius: .ratio(0.7)
                )
                .foregroundStyle(by: .value("Type", "Amount"))
                
                SectorMark(
                    angle: .value("Remaining", remaining),
                    innerRadius: .ratio(0.7)
                )
                .foregroundStyle(by: .value("Type", "Remaining"))
            }
            .chartLegend(.hidden)
            .chartForegroundStyleScale([
                "Amount": gradient != nil ? AnyShapeStyle(gradient!) : AnyShapeStyle(color ?? .red),
                "Remaining": AnyShapeStyle(Color.Chart.neutral)
            ])
            .chartBackground { _ in
                HStack(alignment: .bottom, spacing: 4) {
                    Text(calculatePercentage(from: amount, relativeTo: total).description)
                        .font(isMini ? .cardDataSmall : .cardData)
                        .foregroundStyle(Color.Label.secondary)
                    Text("%")
                        .font(.cardUnit)
                        .foregroundStyle(Color.Label.tertiary)
                        .offset(y: isMini ? -3 : -6)
                }
            }
            Text(title)
                .font(.smallTitle)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
    }
}

// Preview
#Preview {
    VStack(spacing: 40) {
        NutrientDonutPercentage(
            amount: 750,
            total: 1000,
            color: Color.Chart.fats,
            title: "Lipides"
        )
        .frame(height: 250)
        
        NutrientDonutPercentage(
            amount: 120,
            total: 60,
            gradient: LinearGradient.tropical,
            title: "Calories",
            isMini: true
        )
        .frame(height: 150)
    }
}
