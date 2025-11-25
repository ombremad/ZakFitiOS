//
//  OnboardingCard.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import SwiftUI

struct OnboardingCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            self.content
                .font(.callout)
                .foregroundStyle(Color.Label.vibrant)
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    OnboardingCard {
        Text("Pour commencer, nous allons avoir besoin de quelques informations de base pour configurer ton profil.")
            .font(.smallTitle)
        Text("Tu pourras changer ces informations à tout moment plus tard.")
            .font(.smallTitle)
    }
    .background {
        LinearGradient.accent
            .ignoresSafeArea()
    }
}
