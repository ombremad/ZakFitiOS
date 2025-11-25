//
//  InteractiveBox.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import SwiftUI

struct InteractiveBox<Content: View>: View {
    var label: String
    let content: Content
    var state: InteractiveBoxState = .normal
    enum InteractiveBoxState {
        case normal, onboarding
    }
            
    init(label: String, state: InteractiveBoxState = .normal, @ViewBuilder content: () -> Content) {
            self.label = label
            self.state = state
            self.content = content()
        }
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                    .font(.cardTitle)
                Spacer()
                Image(systemName: "pencil.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18)
            }
            Spacer()
            HStack(alignment: .bottom, spacing: 6) {
                Spacer()
                self.content
            }
        }
        .foregroundStyle(state == .onboarding ? Color.Label.vibrant : Color.Label.secondary)
        .frame(height: 60)
        .padding(16)
        .glassEffect(state == .onboarding ? .clear.interactive() : .regular.interactive(), in: .rect(cornerRadius: 25))
        .shadow(radius: 4)
    }
}

#Preview {
    VStack {
        InteractiveBox(label: "Poids", state: .normal) {
            Text("66")
                .font(.cardData)
            Text("kg")
                .font(.cardUnit)
                .offset(y: -5)
        }
            .padding(.vertical, 50)
            .padding(.horizontal)
            .background {
                LinearGradient.tropical
            }
        InteractiveBox(label: "Poids", state: .onboarding) {
            Text("66")
                .font(.cardData)
            Text("kg")
                .font(.cardUnit)
                .offset(y: -5)
        }
            .padding(.vertical, 50)
            .padding(.horizontal)
            .background {
                LinearGradient.accent
            }
    }
}
