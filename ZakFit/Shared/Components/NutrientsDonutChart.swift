//
//  NutrientsDonutChart.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI
import Charts

struct NutrientsDonutChart: View {
    let carbs: Int
    let fats: Int
    let prots: Int
    
    private var data: [(String, Int, Color)] {
        [
            ("Glucides", carbs, Color.Chart.carbs),
            ("Lipides", fats, Color.Chart.fats),
            ("Protéines", prots, Color.Chart.prots)
        ]
    }
    
    var body: some View {
        Chart(data, id: \.0) { item in
            SectorMark(
                angle: .value("Calories", item.1),
                innerRadius: .ratio(0.6)
            )
            .foregroundStyle(item.2)
        }
    }
}
