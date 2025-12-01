//
//  SortingBox.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import SwiftUI

struct SortingBox: View {
    var label: String
    var value: String? = nil
                
    var body: some View {
        HStack {
            if let value = value {
                Text(value)
                    .font(.cardTitle)
            } else {
                Text(label)
                    .font(.cardTitle)
            }
            Spacer()
            Image(systemName: "chevron.up.chevron.down")
        }
        .foregroundStyle(Color.Label.secondary)
        .padding(16)
        .glassEffect(.regular.tint(value == nil ? .clear : Color.Card.darkBackground).interactive(), in: .rect(cornerRadius: 25))
    }
}

#Preview {
    SortingBox(label: "Activité")
}
