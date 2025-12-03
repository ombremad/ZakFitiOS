//
//  GoalExerciseRow.swift
//  ZakFit
//
//  Created by Anne Ferret on 03/12/2025.
//

import SwiftUI

struct GoalExerciseRow: View {
    let name: String
    let icon: String
    let level: Int
    let frequency: Int
    var length: Int? = nil
    var cals: Int? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundStyle(Color.Label.tertiary)
                .frame(width: 56)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    LevelIcon(level: level)
                        .frame(width: 24)
                    Text(name)
                        .font(.listHeader)
                        .foregroundStyle(Color.Label.secondary)
                }
                
                Text(frequency.description + " fois par semaine")
                    .font(.listSubheader)
                    .foregroundStyle(Color.Label.tertiary)
            }
            
            Spacer()
            
            VStack {
                if let length = length {
                    Text(length.description)
                        .font(.cardDataSmall)
                        .foregroundStyle(Color.Label.secondary)
                    Text("min")
                        .font(.cardUnit)
                        .foregroundStyle(Color.Label.tertiary)
                } else if let cals = cals {
                    Text(cals.description)
                        .font(.cardDataSmall)
                        .foregroundStyle(Color.Label.secondary)
                    Text("cal")
                        .font(.cardUnit)
                        .foregroundStyle(Color.Label.tertiary)
                }
            }
        }
        .lineLimit(1)
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .glassEffect(.regular.tint(Color.Card.darkBackground), in: .rect(cornerRadius: 25))
        .contentShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    VStack {
        GoalExerciseRow(
            name: "Yoga",
            icon: "figure.yoga",
            level: 2,
            frequency: 3,
            length: 20
        )
        GoalExerciseRow(
            name: "Course sur tapis",
            icon: "figure.run.treadmill",
            level: 3,
            frequency: 1,
            cals: 200
        )
    }
        .padding()
}
