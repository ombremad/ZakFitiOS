//
//  AppTab.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import SwiftUI

enum AppTab: Int, Hashable, CaseIterable {
    case dashboard
    case fitness
    case nutrition
    
    var title: String {
        switch self {
        case .dashboard: return "Tableau de bord"
        case .fitness: return "Fitness"
        case .nutrition: return "Nutrition"
        }
    }
    
    var icon: String {
        switch self {
        case .dashboard: return "person.crop.circle"
        case .fitness: return "figure.run.circle"
        case .nutrition: return "fork.knife.circle"
        }
    }
    
    @ViewBuilder
    func view(vm: MainViewModel) -> some View {
        switch self {
        case .dashboard:
            DashboardView().environment(vm)
        case .fitness:
            FitnessView().environment(vm)
        case .nutrition:
            NutritionView().environment(vm)
        }
    }
}
