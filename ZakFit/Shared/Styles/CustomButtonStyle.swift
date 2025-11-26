//
//  CustomButtonStyle.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    var state: ButtonState = .normal
    enum ButtonState {
        case normal, highlight, validate, cancel
    }
    
    var width: ButtonWidth = .normal
    enum ButtonWidth {
        case normal, full
    }
    
    private func getTintColor() -> Color {
        switch state {
            case .normal: Color.Button.normal
            case .highlight: Color.Button.highlight
            case .validate: Color.Button.validate
            case .cancel: Color.Button.cancel
        }
    }
    
    private func getLabelColor() -> Color {
        switch state {
            case .normal: Color.Label.secondary
            default: Color.Label.vibrant
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .multilineTextAlignment(.center)
            .lineLimit(width == .full ? 2 : 1)
            .frame(maxWidth: width == .full ? .infinity : nil, maxHeight: width == .full ? .infinity : nil)
            .frame(height: width == .full ? 60 : nil)
            .padding(.vertical, width == .full ? 1 : 14)
            .padding(.horizontal, width == .full ? 8 : 24)
            .font(.buttonLabel)
            .foregroundStyle(getLabelColor())
            .glassEffect(.clear.tint(getTintColor()).interactive())
            .contentShape(Capsule())
            .clipShape(Capsule())
    }
}
