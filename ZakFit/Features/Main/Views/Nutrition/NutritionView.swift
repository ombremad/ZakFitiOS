//
//  NutritionView.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import SwiftUI

struct NutritionView: View {
    @Environment(MainViewModel.self) var vm

    var body: some View {
        VStack {
            Text("NutritionView")
        }
    }
}

#Preview {
    NutritionView().environment(MainViewModel())
}
