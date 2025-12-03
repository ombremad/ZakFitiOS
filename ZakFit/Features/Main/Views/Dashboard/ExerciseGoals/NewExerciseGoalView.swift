//
//  NewExerciseGoalView.swift
//  ZakFit
//
//  Created by Anne Ferret on 03/12/2025.
//

import SwiftUI

struct NewExerciseGoalView: View {
    @Environment(MainViewModel.self) var vm
    @Environment(\.dismiss) private var dismiss
    
    // UX values
    @FocusState private var focusedField: Field?
    enum Field { case frequency, length, cals }
    
    // Views
    @ViewBuilder private var exerciseType: some View {
        @Bindable var vm = vm

        VStack(alignment: .leading, spacing: 24) {
            GlassEffectContainer {
                
                Menu {
                    Picker("Activité", selection: $vm.exerciseGoals.selectedExerciseType) {
                        ForEach(vm.fitness.exerciseTypes) { exerciseType in
                            Label {
                                Text("\(exerciseType.name) (int. \(exerciseType.level.description))")
                                    .font(.listHeader)
                                    .foregroundStyle(Color.Label.primary)
                            } icon: {
                                Image(systemName: exerciseType.icon)
                            }
                            .tag(exerciseType)
                        }
                    }
                } label: {
                    DataBox(label: "Type d'entraînement", icon: .list) {
                        if let exerciseType = vm.exerciseGoals.selectedExerciseType {
                            Text(exerciseType.name)
                                .font(.cardDataSmall)
                        }
                    }
                }
                
                DataBox(label: "Nombre d'entraînements par semaine", icon: .numbers) {
                    TextField("", value: $vm.exerciseGoals.frequency, format: .number)
                        .font(.cardData)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .frequency)
                }
                
            }
        }
        .foregroundStyle(Color.Label.secondary)
    }
    private var exerciseGoal: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Objectif par séance")
                .font(.title2)
                .foregroundStyle(Color.Label.secondary)
            GlassEffectContainer {
                HStack {
                    Button("Aucun") { vm.exerciseGoals.goalType = .none }
                        .buttonStyle(CustomButtonStyle(state: vm.exerciseGoals.goalType == .none ? .highlight : .normal, width: .full))
                    Button("Durée") { vm.exerciseGoals.goalType = .length }
                        .buttonStyle(CustomButtonStyle(state: vm.exerciseGoals.goalType == .length ? .highlight : .normal, width: .full))
                    Button("Calories") { vm.exerciseGoals.goalType = .cals }
                        .buttonStyle(CustomButtonStyle(state: vm.exerciseGoals.goalType == .cals ? .highlight : .normal, width: .full))
                }
            }
            
            if vm.exerciseGoals.goalType == .length {
                exerciseGoalLength
            } else if vm.exerciseGoals.goalType == .cals {
                exerciseGoalCals
            }
        }
    }
    @ViewBuilder private var exerciseGoalLength: some View {
        @Bindable var vm = vm
        
        DataBox(label: "Durée minimale", icon: .numbers) {
            TextField("", value: $vm.exerciseGoals.length, format: .number)
                .font(.cardData)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .submitLabel(.next)
                .focused($focusedField, equals: .length)
        }
    }
    @ViewBuilder private var exerciseGoalCals: some View {
        @Bindable var vm = vm
        
        DataBox(label: "Calories dépensées", icon: .numbers) {
            TextField("", value: $vm.exerciseGoals.cals, format: .number)
                .font(.cardData)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .submitLabel(.next)
                .focused($focusedField, equals: .cals)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    
                    exerciseType
                    exerciseGoal
                    ErrorMessage(message: vm.errorMessage)
                    
                }
                .padding()
            }
                        
            .task {
                await vm.initNewExerciseGoal()
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Nouvel entraînement")
                        .font(.smallTitle)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .confirmationAction) {
                    Button("Valider", systemImage: "checkmark") {
                        Task {
                            if await vm.sendNewExerciseGoal() {
                                dismiss()
                            }
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
    NewExerciseGoalView().environment(MainViewModel())
}
