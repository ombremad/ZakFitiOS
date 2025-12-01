//
//  PieChart.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import SwiftUI
import Charts

struct ChartData: Identifiable {
    let id = UUID()
    let title: String
    let value: Double
}

struct PieChart: View {
    let amount: Double
    let total: Double
    let label: String
    
    private var percentage: Double {
        guard total > 0 else { return 0 }
        return (amount / total) * 100
    }
    
    private var data: [ChartData] {
        [
            .init(title: "Amount", value: amount),
            .init(title: "Remaining", value: max(0, total - amount))
        ]
    }
    
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                HStack(alignment: .bottom) {
                    Text(String(format: "%.0f", percentage))
                        .font(.cardData)
                        .foregroundStyle(Color.Label.secondary)
                    Text("%")
                        .font(.cardUnit)
                        .foregroundStyle(Color.Label.tertiary)
                        .offset(y: -5)
                }
                Chart(data) { item in
                    SectorMark(
                        angle: .value(
                            Text(verbatim: item.title),
                            item.value
                        ),
                        innerRadius: .ratio(0.7)
                    )
                    .foregroundStyle(
                        item.title == "Amount" ? LinearGradient.tropical : LinearGradient.gray
                    )
                }
                .chartLegend(.hidden)
            }
            Text(label)
                .font(.caption)
                .foregroundStyle(Color.Label.secondary)
        }
    }
}

// Usage example:
#Preview {
    PieChart(amount: 820, total: 1000, label: "Example")
        .frame(width: 200, height: 200)
}
