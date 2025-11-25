//
//  CustomTextFieldStyle.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundStyle(Color.Label.secondary)
            .font(.inputLabel)
            .padding()
            .glassEffect(.clear)
    }
}
