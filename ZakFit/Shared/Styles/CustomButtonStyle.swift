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
        VStack {
            if width == .full { Spacer() }
            HStack {
                if width == .full { Spacer() }
                configuration.label
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                if width == .full { Spacer() }
            }
            if width == .full { Spacer() }
        }
            .frame(height: width == .full ? 60 : .infinity)
            .padding(.vertical, width == .full ? 1 : 8)
            .padding(.horizontal, width == .full ? 1 : 16)
            .font(.buttonLabel)
            .foregroundStyle(getLabelColor())
            .glassEffect(.clear.tint(getTintColor()).interactive())
            .clipShape(Capsule())
    }
}
