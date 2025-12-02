//
//  MealRow.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct MealRow: View {
    let name: String
    let date: Date
    let calories: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.listHeader)
                Text(date.formatted(.dateTime))
                    .font(.listSubheader)
                    .foregroundStyle(Color.Label.tertiary)
            }
            Spacer()
            Text("\(calories) kcal")
                .font(.listDetail)
            Image(systemName: "chevron.forward")
        }
        .foregroundStyle(Color.Label.secondary)
        .lineLimit(1)
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .glassEffect(.regular.tint(Color.Card.darkBackground), in: .rect(cornerRadius: 25))
    }
}

#Preview {
    MealRow(name: "Petit déjeuner", date: .now, calories: 200)
        .padding()
}
