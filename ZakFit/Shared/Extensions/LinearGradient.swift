//
//  LinearGradient.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import SwiftUI

extension LinearGradient {
    static let tropical = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.Gradient.Tropical.start, location: 0),
            Gradient.Stop(color: Color.Gradient.Tropical.end, location: 0.7)
        ],
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )
    
    static let primary = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.Gradient.Primary.start, location: 0),
            Gradient.Stop(color: Color.Gradient.Primary.end, location: 0.7)
        ],
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )
    
    static let accent = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.Gradient.Accent.start, location: 0),
            Gradient.Stop(color: Color.Gradient.Accent.end, location: 0.7)
        ],
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )
    
    static let neutral = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.Gradient.Neutral.start, location: 0),
            Gradient.Stop(color: Color.Gradient.Neutral.end, location: 0.7)
        ],
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )

    static let clear = LinearGradient(
        colors: [.clear],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let gray = LinearGradient(
        colors: [Color.Label.tertiary],
        startPoint: .top,
        endPoint: .bottom
    )
}
