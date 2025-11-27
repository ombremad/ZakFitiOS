//
//  FitnessView.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import SwiftUI

struct FitnessView: View {
    @Environment(MainViewModel.self) var vm

    var body: some View {
        VStack {
            Text("FitnessView")
        }
    }
}

#Preview {
    FitnessView().environment(MainViewModel())
}
