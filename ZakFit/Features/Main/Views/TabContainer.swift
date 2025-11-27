//
//  TabContainer.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import SwiftUI

struct TabContainer: View {
    @State var vm = MainViewModel()
    
    var body: some View {
        VStack {
            TabView {
                Tab("Tableau de bord", systemImage: "person.crop.circle") {
                    DashboardView().environment(vm)
                }
                Tab("Fitness", systemImage: "figure.run.circle") {
                    FitnessView().environment(vm)
                }
                Tab("Nutrition", systemImage: "fork.knife.circle") {
                    NutritionView().environment(vm)
                }
            }
        }
    }
}

#Preview {
    TabContainer()
}
