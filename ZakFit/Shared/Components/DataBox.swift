//
//  InteractiveBox.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import SwiftUI

struct DataBox<Content: View>: View {
    var label: String
    let content: Content
    var theme: DataBoxTheme
    var icon: DataBoxIcon
    var isInteractive: Bool
    
    enum DataBoxTheme {
        case normal, onboarding
    }
    enum DataBoxIcon {
        case none, numbers, calendar, list
    }
            
    init(
        label: String,
        theme: DataBoxTheme = .normal,
        icon: DataBoxIcon = .none,
        isInteractive: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.label = label
        self.theme = theme
        self.icon = icon
        self.isInteractive = isInteractive
        self.content = content()
    }
    
    private func getIconName() -> String {
        switch icon {
            case .numbers: return "numbers.rectangle"
            case .calendar: return "calendar"
            case .list: return "list.bullet"
            default: return ""
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                    .font(.cardTitle)
                Spacer()
                Image(systemName: getIconName())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22)
            }
            Spacer()
            HStack(alignment: .bottom, spacing: 6) {
                Spacer()
                self.content
            }
        }
        .foregroundStyle(theme == .onboarding ? Color.Label.vibrant : Color.Label.secondary)
        .frame(height: 60)
        .padding(16)
        .glassEffect(theme == .onboarding ? .clear.interactive() : .regular.interactive(), in: .rect(cornerRadius: 25))
        .shadow(radius: 4)
    }
}

#Preview {
    VStack {
        HStack {
            DataBox(label: "Poids", theme: .normal, isInteractive: false) {
                Text("66")
                    .font(.cardData)
                Text("kg")
                    .font(.cardUnit)
                    .offset(y: -5)
            }
            DataBox(label: "Poids", theme: .normal, isInteractive: false) {
                Text("66")
                    .font(.cardData)
                Text("kg")
                    .font(.cardUnit)
                    .offset(y: -5)
            }
        }
            .padding(.vertical, 50)
            .padding(.horizontal)
            .background {
                Color.App.background
            }
        DataBox(label: "Poids", theme: .normal, icon: .numbers) {
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
        DataBox(label: "Poids", theme: .onboarding, icon: .numbers) {
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
