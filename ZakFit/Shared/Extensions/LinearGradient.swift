//
//  LinearGradient.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import SwiftUI

extension LinearGradient {
    static let tropical = LinearGradient(
        colors: [
            Color.Gradient.Tropical.start,
            Color.Gradient.Tropical.end
        ],
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )
    
    static let primary = LinearGradient(
        colors: [
            Color.Gradient.Primary.start,
            Color.Gradient.Primary.end
        ],
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )
    
    static let accent = LinearGradient(
        colors: [
            Color.Gradient.Accent.start,
            Color.Gradient.Accent.end
        ],
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )
    
    static let neutral = LinearGradient(
        colors: [
            Color.Gradient.Neutral.start,
            Color.Gradient.Neutral.end
        ],
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )

    static let clear = LinearGradient(
        colors: [.clear],
        startPoint: .top,
        endPoint: .bottom
    )
}
