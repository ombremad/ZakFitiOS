//
//  CustomButtonStyle.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    let state: ButtonState?
    
    enum ButtonState {
        case normal, validate, cancel
    }
    
    private func getTintColor() -> Color {
        switch state {
            case .normal: Color.Button.normal
            case .validate: Color.Button.validate
            case .cancel: Color.Button.cancel
            default: Color.Button.normal
        }
    }
    
    private func getLabelColor() -> Color {
        switch state {
            case .normal: Color.Label.secondary
            case .validate: Color.Label.vibrant
            case .cancel: Color.Label.vibrant
            default: Color.Label.secondary
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.buttonLabel)
            .foregroundStyle(getLabelColor())
            .glassEffect(.clear.tint(getTintColor()).interactive())
            .clipShape(Capsule())
    }
}
