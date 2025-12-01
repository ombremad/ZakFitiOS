//
//  LevelIcon.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import SwiftUI

struct LevelIcon: View {
    let level: Int
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: geometry.size.width * 0.1) {
                ForEach(0..<3) { index in
                    Rectangle()
                        .fill(index < level ? Color.Label.primary : Color.Label.tertiary)
                        .frame(
                            width: geometry.size.width * 0.175,
                            height: geometry.size.height * heightRatio(for: index)
                        )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .aspectRatio(1.6, contentMode: .fit)
    }
    
    private func heightRatio(for index: Int) -> CGFloat {
        let ratios: [CGFloat] = [0.33, 0.67, 1.0]
        return ratios[index]
    }
}

#Preview {
    LevelIcon(level: 2)
        .frame(width: 100, height: 100)
}
