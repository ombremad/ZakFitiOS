//
//  ExerciseRow.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import SwiftUI

struct ExerciseRow: View {
    let name: String
    let icon: String
    let date: Date
    let length: Int
    let calories: Int
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundStyle(Color.Label.tertiary)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.listHeader)
                    .foregroundStyle(Color.Label.secondary)
                
                VStack(alignment: .leading) {
                    Text(date.formatted(.dateTime))
                        .font(.listSubheader)
                        .foregroundStyle(Color.Label.tertiary)
                    Text(length.description + " minutes")
                        .font(.listSubheader)
                        .foregroundStyle(Color.Label.secondary)
                }
            }
            
            Spacer()
            
            VStack {
                Text(calories.description)
                    .font(.cardDataSmall)
                    .foregroundStyle(Color.Label.secondary)
                Text("cal")
                    .font(.cardUnit)
                    .foregroundStyle(Color.Label.tertiary)
            }
        }
        .lineLimit(1)
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .glassEffect(.regular.tint(Color.Card.darkBackground), in: .rect(cornerRadius: 25))
    }
}

#Preview {
    ExerciseRow(
        name: "Yoga",
        icon: "figure.yoga",
        date: .now,
        length: 20,
        calories: 155
    )
        .padding()
}
