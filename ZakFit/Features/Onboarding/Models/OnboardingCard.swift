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
