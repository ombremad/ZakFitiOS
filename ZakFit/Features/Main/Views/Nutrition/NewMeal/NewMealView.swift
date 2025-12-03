//
//  NewMealView.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct NewMealView: View {
    @Environment(MainViewModel.self) var vm
    
    // Form values
    @State var selectedMealType: MealType? = nil
    @State var date: Date = .now
    
    // UX values
    @State private var showCalendar: Bool = false
    
    // Views
    private var calendar: some View {
        VStack {
            DatePicker("", selection: $date, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.graphical)
            .labelsHidden()
            .frame(maxWidth: .infinity, alignment: .center)
            
            Button("Valider") {
                showCalendar = false
            }
            .buttonStyle(CustomButtonStyle(state: .validate))
        }
        .presentationDetents([.fraction(0.70)])
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack {
                    ForEach(vm.nutrition.mealTypes) { mealType in
                        MealTypeRow(name: mealType.name, isSelected: selectedMealType == mealType)
                            .onTapGesture {
                                withAnimation {
                                    selectedMealType = mealType
                                }
                            }
                    }
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    DataBox(label: "Date et heure", icon: .calendar) {
                        HStack(spacing: 12) {
                            HStack(spacing: 4) {
                                Text(date.formatted(.dateTime.day(.twoDigits)))
                                    .font(.cardDataSmall)
                                Text("/")
                                    .font(.cardUnit)
                                Text(date.formatted(.dateTime.month(.twoDigits)))
                                    .font(.cardDataSmall)
                                Text("/")
                                    .font(.cardUnit)
                                Text(date.formatted(.dateTime.year()))
                                    .font(.cardDataSmall)
                            }
                            HStack(spacing: 4) {
                                Text(date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted))))
                                    .font(.cardDataSmall)
                                Text(":")
                                    .font(.cardUnit)
                                Text(date.formatted(.dateTime.minute(.twoDigits)))
                                    .font(.cardDataSmall)
                            }
                        }
                    }
                    .onTapGesture {
                        showCalendar = true
                    }
                    ErrorMessage(message: vm.errorMessage)

                }
                
            }
            .padding()
            
            .task {
                await vm.initNewMeal()
            }
            
            .sheet(isPresented: $showCalendar) { calendar }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Nouveau repas")
                        .font(.smallTitle)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .primaryAction) {
                    Button("Suivant", systemImage: "chevron.forward") {
                        vm.goToFoodSelection(selectedMealType: selectedMealType, date: date)
                    }
                }
            }
            
            .navigationDestination(isPresented: Binding(
                get: { vm.nutrition.shouldNavigateToFoodSelection },
                set: { vm.nutrition.shouldNavigateToFoodSelection = $0 }
            )) {
                FoodSelectionView(mealType: selectedMealType ?? MealType(id: UUID(), name: "undefined"), date: date).environment(vm)
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
    NewMealView().environment(MainViewModel())
}
