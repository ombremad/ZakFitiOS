//
//  NewFoodItem.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct NewFoodItem: View {
    @Environment(MainViewModel.self) var vm
    @Environment(\.dismiss) private var dismiss
    
    // Form values
    @State var mealType: MealType
    @State var selectedFoodType: FoodType? = nil
    @State var weight: Int? = nil
    @State var quantity: Int? = nil
    
    // UX values
    @FocusState private var focusedField: Field?
    enum Field { case weight, quantity }
    
    // Views
    private var foodTypeList: some View {
        ScrollView {
            VStack {
                ForEach(vm.nutrition.foodTypes) { foodType in
                    FoodTypeRow(name: foodType.name, isSelected: selectedFoodType?.id == foodType.id)
                        .onTapGesture {
                            withAnimation {
                                selectedFoodType = foodType
                            }
                        }
                }
            }
            .padding()
            .padding(.bottom, 128)
        }
    }
    private var quantityInput: some View {
        VStack {
            Spacer()
            if let foodType = selectedFoodType {
                DataBox(label: "Quantité", icon: .numbers) {
                    if foodType.weightPerServing == nil {
                        TextField("", value: $weight, format: .number)
                            .font(.cardData)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .submitLabel(.go)
                            .focused($focusedField, equals: .weight)
                        Text("grammes")
                            .font(.cardUnit)
                            .offset(y: -5)
                    } else {
                        TextField("", value: $quantity, format: .number)
                            .font(.cardData)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .submitLabel(.go)
                            .focused($focusedField, equals: .quantity)
                        Text("unités")
                            .font(.cardUnit)
                            .offset(y: -5)
                    }
                }
            }
            ErrorMessage(message: vm.errorMessage)

        }
        .padding()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                foodTypeList
                quantityInput
                
            }
                        
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Ajouter un aliment")
                        .font(.smallTitle)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .confirmationAction) {
                    Button("Valider", systemImage: "checkmark") {
                        if vm.addFoodItem(mealType: mealType, foodType: selectedFoodType, weight: weight, quantity: quantity) {
                            dismiss()
                        }
                    }
                        .tint(Color.Button.validate)
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
    NewFoodItem(
        mealType: MealType(id: UUID(), name: "Petit déjeuner")
    )
    .environment(MainViewModel())
}
