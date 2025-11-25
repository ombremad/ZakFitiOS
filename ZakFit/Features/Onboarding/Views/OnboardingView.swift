//
//  OnboardingView.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentTab = 0

    var body: some View {
        NavigationStack {
            TabView(selection: $currentTab) {
                
                OnboardingCard {
                    Text("Pour commencer, nous allons avoir besoin de quelques informations de base pour configurer ton profil.")
                        .font(.smallTitle)
                    Text("Tu pourras changer ces informations à tout moment plus tard.")
                        .font(.smallTitle)
                }
                .tag(0)
                
                OnboardingCard {
                    Text("Ma morphologie")
                        .font(.title2)
                    HStack(spacing: 12) {
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                        Text("Ces informations sont indispensables pour calculer les calories et macro-nutriments qui serviront de base à ton programme fitness et nutrition.")
                            .font(.callout)
                    }
                }
                .tag(1)
                
                OnboardingCard {
                    Text("là")
                }
                .tag(2)
                
                OnboardingCard {
                    Text("ici")
                }
                .tag(3)

                
                OnboardingCard {
                    VStack(alignment: .center, spacing: 48) {
                        Image(.welcome)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 215)
                        Button("Commencer") {}
                            .buttonStyle(CustomButtonStyle(state: .validate))
                    }
                }
                .tag(4)
                
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .toolbar {
                if currentTab < 4 {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Suivant", systemImage: "chevron.forward") {
                            withAnimation {
                                currentTab += 1
                            }
                        }
                    }
                }
                if currentTab > 0 {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Précédent", systemImage: "chevron.backward") {
                            withAnimation {
                                currentTab -= 1
                            }
                        }
                    }
                }
            }
            
            .background {
                LinearGradient.accent
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    OnboardingView()
}
