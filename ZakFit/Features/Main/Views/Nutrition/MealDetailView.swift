//
//  MealDetailView.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct MealDetailView: View {
    @Environment(MainViewModel.self) var vm
    let id: UUID
    
    var mealOverview: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(vm.nutrition.meal.date?.formatted(.dateTime) ?? "")
                .font(.caption)
                .foregroundStyle(Color.Label.secondary)
            NutrientsTable(
                cals: vm.nutrition.meal.cals ?? 0,
                carbs: vm.nutrition.meal.carbs ?? 0,
                fats: vm.nutrition.meal.fats ?? 0,
                prots: vm.nutrition.meal.prots ?? 0
            )
        }
    }
    var foodItems: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Détail")
                .font(.title2)
                .foregroundStyle(Color.Label.primary)
            if let foods = vm.nutrition.meal.foods {
                ForEach(Array(foods.indices), id: \.self) { index in
                    NutrientsTable(
                        title: foods[index].foodType.name,
                        cals: foods[index].cals,
                        carbs: foods[index].carbs,
                        fats: foods[index].fats,
                        prots: foods[index].prots
                    )
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        mealOverview
                        foodItems
                    }
                    
                }
                .padding()
            }
            .task {
                await vm.fetchMealDetail(id: id)
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text(vm.nutrition.meal.mealType?.name ?? "")
                        .font(.smallTitle)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)
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
