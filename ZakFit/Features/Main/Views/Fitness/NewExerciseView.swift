//
//  NewExerciseView.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import SwiftUI

struct NewExerciseView: View {
    @Environment(MainViewModel.self) var vm
    @Environment(\.dismiss) private var dismiss
    
    // Form values
    @State private var selectedExerciseType: ExerciseType? = nil
    @State private var length: Int? = nil
    @State private var cals: Int? = nil
    
    @FocusState private var focusedField: Field?
    enum Field { case length, cals }
    
    // Functions
    private func calculateBurnedCals() {
        cals = (selectedExerciseType?.calsPerMinute ?? 0) * (length ?? 0)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        ForEach(vm.exerciseTypes) { exerciseType in
                            ExerciseTypeRow(
                                name: exerciseType.name,
                                icon: exerciseType.icon,
                                level: exerciseType.level,
                                isSelected: selectedExerciseType == exerciseType
                            )
                            .onTapGesture {
                                withAnimation {
                                    selectedExerciseType = exerciseType
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                }
                VStack {
                    Spacer()
                    GlassEffectContainer {
                        HStack {
                            DataBox(label: "Durée", icon: .numbers) {
                                TextField("", value: $length, format: .number)
                                    .font(.cardData)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                    .submitLabel(.go)
                                    .focused($focusedField, equals: .length)
                                Text("min")
                                    .font(.cardUnit)
                                    .offset(y: -5)
                            }
                            .onTapGesture {
                                focusedField = .length
                            }
                            DataBox(label: "Calories brûlées", icon: .numbers) {
                                TextField("", value: $cals, format: .number)
                                    .font(.cardData)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                    .submitLabel(.go)
                                    .focused($focusedField, equals: .cals)
                                Text("cal")
                                    .font(.cardUnit)
                                    .offset(y: -5)
                            }
                            .onTapGesture {
                                focusedField = .cals
                            }
                        }
                    }
                    Text(vm.errorMessage)
                        .font(.caption)
                        .foregroundStyle(Color.Label.secondary)
                }
                .padding()
            }
            
            .onChange(of: length) {
                calculateBurnedCals()
            }
            .onChange(of: selectedExerciseType) {
                calculateBurnedCals()
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Nouvelle activité")
                        .font(.smallTitle)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirmer", systemImage: "checkmark") {
                        Task {
                            if await vm.sendNewExercise(exerciseType: selectedExerciseType, length: length, cals: cals) == true {
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
    NewExerciseView().environment(MainViewModel())
}
