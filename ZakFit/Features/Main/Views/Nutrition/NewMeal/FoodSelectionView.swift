//
//  FoodSelectionView.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct FoodSelectionView: View {
    @Environment(MainViewModel.self) var vm
    
    // Form values
    @State var mealType: MealType
    @State var date: Date
    @State var foods: [Food] = []
    
    // Views
    private var foodList: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Aliments")
                .font(.title2)
                .foregroundStyle(Color.Label.primary)
            NavigationLink {
                NewFoodItem(foods: $foods, mealType: mealType).environment(vm)
            } label: {
                Text("Ajouter un aliment")
            }
            .buttonStyle(CustomButtonStyle(state: .validate))
        }
    }
    @ViewBuilder private var total: some View {
        if !foods.isEmpty {
            VStack(alignment: .leading, spacing: 24) {
                Text("Total")
                    .font(.title2)
                    .foregroundStyle(Color.Label.primary)
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
                    Button("Valider", systemImage: "checkmark") {}
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
