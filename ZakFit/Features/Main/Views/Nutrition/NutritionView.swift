//
//  NutritionView.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import SwiftUI

struct NutritionView: View {
    @Environment(MainViewModel.self) var vm
    
    private var mealsToday: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Repas")
                    .font(.title2)
                    .foregroundStyle(Color.Label.primary)
                Text("Aujourd'hui")
                    .font(.callout2)
                    .foregroundStyle(Color.Label.tertiary)
            }
            GlassEffectContainer {
                ForEach(vm.nutrition.meals) { meal in
                    NavigationLink {
                        MealDetailView(id: meal.id).environment(vm)
                    } label: {
                        MealRow(
                            name: meal.mealTypeName,
                            date: meal.date,
                            calories: meal.cals
                        )
                    }
                }
            }
            NavigationLink {
                MealListView().environment(vm)
            } label: {
                HStack {
                    Spacer()
                    Text("Historique des repas")
                        .font(.caption)
                    Image(systemName: "chevron.forward")
                }
                .foregroundStyle(Color.Label.secondary)
            }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    
                    mealsToday
                    
                }
                .padding()
            }
            .task {
                await vm.fetchNutritionData()
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Nutrition")
                        .font(.title)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .confirmationAction) {
                    NavigationLink {
                        NewMealView().environment(vm)
                    } label: {
                        Label("Nouveau repas", systemImage: "plus")
                            .tint(Color.Button.validate)
                    }
                }
            }
            
            .scrollDismissesKeyboard(.immediately)
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
    NutritionView().environment(MainViewModel())
}
