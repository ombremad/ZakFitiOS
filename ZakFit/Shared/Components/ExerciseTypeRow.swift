//
//  ExerciseTypeRow.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import SwiftUI

struct ExerciseTypeRow: View {
    var name: String
    var icon: String
    var level: Int
    var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 17))
                .frame(width: 24, alignment: .leading)
            Text(name)
                .font(.listLabel)
            Spacer()
            LevelIcon(level: level)
                .frame(width: 28)
        }
        .padding()
        .foregroundStyle(isSelected ? Color.Label.vibrant : Color.Label.primary)
        .background(isSelected ? Color.accentColor : Color.clear)
        .cornerRadius(15)
        .contentShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    VStack {
        ExerciseTypeRow(name: "Natation", icon: "figure.pool.swim", level: 2)
        ExerciseTypeRow(name: "Yoga", icon: "figure.yoga", level: 2, isSelected: true)
    }
}
