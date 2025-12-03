//
//  ErrorMessage.swift
//  ZakFit
//
//  Created by Anne Ferret on 03/12/2025.
//

import SwiftUI

struct ErrorMessage: View {
    var message: String = ""

    var body: some View {
        HStack(alignment: .center) {
            if !message.isEmpty {
                Text(message)
                    .font(.callout)
                    .foregroundStyle(Color.Label.vibrant)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .glassEffect(.regular.tint(Color.Button.cancel.opacity(0.85)))
            } else {
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VStack {
        ErrorMessage(message: "Ceci est un message d'erreur.")
        ErrorMessage(message: "")
    }
}
