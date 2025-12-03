//
//  MealTypeRow.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct MealTypeRow: View {
    var name: String
    var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Text(name)
                .font(.listLabel)
            Spacer()
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
        MealTypeRow(name: "Petit déjeuner")
    }
}
