//
//  DashboardView.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import SwiftUI

struct DashboardView: View {
    @Environment(MainViewModel.self) var vm
    
    @ViewBuilder
    private var nutrientsOverview: some View {
        VStack(spacing: 24) {
                NutrientDonutPercentage(
                    amount: vm.calsToday ?? 0,
                    total: vm.user.goalCals ?? 9,
                    gradient: LinearGradient.tropical,
                    title: "Calories consommées"
                )
                    .frame(height: 150)
            HStack {
                    NutrientDonutPercentage(
                        amount: vm.carbsToday ?? 0,
                        total: vm.user.goalCarbs ?? 0,
                        color: Color.Chart.carbs,
                        title: "Glucides",
                        isMini: true
                    )
                        .frame(height: 100)
                    NutrientDonutPercentage(
                        amount: vm.fatsToday ?? 0,
                        total: vm.user.goalFats ?? 0,
                        color: Color.Chart.fats,
                        title: "Lipides",
                        isMini: true
                    )
                        .frame(height: 100)
                    NutrientDonutPercentage(
                        amount: vm.protsToday ?? 0,
                        total: vm.user.goalProts ?? 0,
                        color: Color.Chart.prots,
                        title: "Protéines",
                        isMini: true
                    )
                        .frame(height: 100)
            }
        }
    }
    private var programButtons: some View {
        HStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Définir mon programme")
                        .font(.cardTitle)
                        .foregroundStyle(Color.Label.vibrant)
                    Text("diététique")
                        .font(.cardBigTitle)
                        .foregroundStyle(Color.Label.secondary)
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient.accent)
            .cornerRadius(25)

            HStack {
                VStack(alignment: .leading) {
                    Text("Définir mon programme")
                        .font(.cardTitle)
                        .foregroundStyle(Color.Label.vibrant)
                    Text("physique")
                        .font(.cardBigTitle)
                        .foregroundStyle(Color.Label.secondary)
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient.primary)
            .cornerRadius(25)
        }
    }
    private var advice: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Image(.logotype)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90)
                Text("N'oubliez pas de **rester actif** et de **manger sainement** ! Aussi, cette infobox n'est pas encore liée à de la vraie data.")
                    .font(.cardSubheader)
                    .foregroundStyle(Color.Label.secondary)
            }
            Spacer()
        }
        .padding()
        .glassEffect(.regular, in: .rect(cornerRadius: 25))
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 36) {
                
                nutrientsOverview
                programButtons
                advice
                
            }
            .padding()
                        
            .task {
                await vm.fetchDashboardData()
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Aujourd'hui")
                        .font(.title)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        UserSettingsView().environment(vm)
                    } label: {
                    HStack {
                        Text(vm.user.firstName ?? "undefined")
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)
                    }
                    .font(.caption)
                    .foregroundStyle(Color.Label.secondary)
                    }
                }
                .sharedBackgroundVisibility(.hidden)
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.App.background
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    DashboardView().environment(MainViewModel())
}
