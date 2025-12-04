//
//  NutrientStackedBars.swift
//  ZakFit
//
//  Created by Anne Ferret on 04/12/2025.
//

import SwiftUI

struct NutrientStackedBars: View {
    let amount: Int
    let total: Int
    let color: Color
    
    @State private var amountGeo: Double = 0
    @State private var totalGeo: Double = 0
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("aujourd'hui")
                    .frame(width: 60, alignment: .trailing)
                GeometryReader { geo in
                    Rectangle()
                        .fill(color)
                        .frame(width: geo.size.width * amountGeo)
                }
            }
            HStack {
                Text("objectif")
                    .frame(width: 60, alignment: .trailing)
                GeometryReader { geo in
                    Rectangle()
                        .fill(color.opacity(0.35))
                        .frame(width: geo.size.width * totalGeo)
                }
            }
        }
        .font(.cardCaption)
        .foregroundStyle(Color.Label.tertiary)
        
        .onAppear {
            if amount <= 0 || total <= 0 {
                amountGeo = 0
                totalGeo = 1
            } else if amount > total {
                amountGeo = 1
                totalGeo = Double(self.total) / Double(self.amount)
            } else {
                amountGeo = Double(self.amount) / Double(self.total)
                totalGeo = 1
            }
        }
            
    }
}

#Preview {
    VStack(spacing: 24) {
        NutrientStackedBars(amount: 32, total: 100, color: Color.Chart.carbs)
            .frame(height: 50)
        NutrientStackedBars(amount: 418, total: 500, color: Color.Chart.fats)
            .frame(height: 50)
    }
    .padding(.horizontal, 50)
}
