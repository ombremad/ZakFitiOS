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
            Text("overview")
        }
    }
    var foodItems: some View {
        Text("food items")
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    
                    mealOverview
                    foodItems
                    
                }
                .padding()
            }
            .task {
                await vm.fetchMealDetail(id: id)
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text(vm.meal.mealType?.name ?? "undefined")
                        .font(.smallTitle)
                        .foregroundStyle(Color.Label.primary)
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
