//
//  NewFoodItem.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct NewFoodItem: View {
    @Environment(MainViewModel.self) var vm
    
    // Form values
    @Binding var foods: [Food]
    @State var mealType: MealType
    @State var selectedFoodType: FoodType? = nil
    
    // Views
    private var foodTypeList: some View {
        ScrollView {
            VStack {
                ForEach(vm.foodTypes) { foodType in
                    FoodTypeRow(name: foodType.name, isSelected: selectedFoodType?.id == foodType.id)
                        .onTapGesture {
                            withAnimation {
                                selectedFoodType = foodType
                            }
                        }
                }
            }
            .padding()
        }
    }
    private var quantityInput: some View {
        VStack {
            Spacer()
            DataBox(label: "Quantité", icon: .numbers) {}
        }
        .padding()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                foodTypeList
                quantityInput
                
            }
            
            .task {
                await vm.fetchFoodTypes(mealType: mealType, restrictionTypes: vm.user.restrictionTypes)
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Ajouter un aliment")
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
    NewFoodItem(
        foods: .constant([]),
        mealType: MealType(id: UUID(), name: "Petit déjeuner")
    )
    .environment(MainViewModel())
}
