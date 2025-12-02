//
//  FoodSelectionView.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct FoodSelectionView: View {
    @Environment(MainViewModel.self) var vm
    @Environment(\.dismiss) private var dismiss
    
    // Form values
    @State var mealType: MealType
    @State var date: Date
    @State private var totalCals: Int = 0
    @State private var totalCarbs: Int = 0
    @State private var totalFats: Int = 0
    @State private var totalProts: Int = 0
    
    // Views
    private var foodList: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Aliments")
                .font(.title2)
                .foregroundStyle(Color.Label.primary)
            
            ForEach(vm.foods) { food in
                NutrientsTable(title: food.foodType.name, cals: food.cals, carbs: food.carbs, fats: food.fats, prots: food.prots)
            }

            HStack(alignment: .center) {
                NavigationLink {
                    NewFoodItem(mealType: mealType).environment(vm)
                } label: {
                    Text("Ajouter un aliment")
                }
                .buttonStyle(CustomButtonStyle(state: .validate))
            }
            .frame(maxWidth: .infinity)
        }
    }
    @ViewBuilder private var total: some View {
        if !vm.foods.isEmpty {
            VStack(alignment: .leading, spacing: 24) {
                Text("Total")
                    .font(.title2)
                    .foregroundStyle(Color.Label.primary)
                
                NutrientsTable(cals: totalCals, carbs: totalCarbs, fats: totalFats, prots: totalProts)
            }
            .task {
                totalCals = vm.foods.reduce(0) { $0 + $1.cals }
                totalCarbs = vm.foods.reduce(0) { $0 + $1.carbs }
                totalFats = vm.foods.reduce(0) { $0 + $1.fats }
                totalProts = vm.foods.reduce(0) { $0 + $1.prots }
            }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    
                    foodList
                    total
                    
                }
                .padding()
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text(mealType.name)
                        .font(.smallTitle)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .confirmationAction) {
                    Button("Valider", systemImage: "checkmark") {
                        Task {
                            if await vm.addMeal(mealType: mealType, date: date, cals: totalCals, carbs: totalCarbs, fats: totalFats, prots: totalProts) {
                                dismiss()
                            }
                        }
                    }
                        .tint(Color.Button.validate)
                }
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
    FoodSelectionView(
        mealType: MealType(id: UUID(), name: "Petit déjeuner"),
        date: .now
    ).environment(MainViewModel())
}
