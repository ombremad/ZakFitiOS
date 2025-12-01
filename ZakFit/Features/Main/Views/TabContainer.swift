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
            TabView(selection: $vm.selectedTab) {
                Tab("Tableau de bord", systemImage: "person.crop.circle", value: .dashboard) {
                    DashboardView().environment(vm)
                }
                Tab("Fitness", systemImage: "figure.run.circle", value: .fitness) {
                    FitnessView().environment(vm)
                }
                Tab("Nutrition", systemImage: "fork.knife.circle", value: .nutrition) {
                    NutritionView().environment(vm)
                }
            }
        }
    }
}

#Preview {
    TabContainer()
}
