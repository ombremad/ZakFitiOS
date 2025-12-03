//
//  NutritionGoal.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct NutritionGoal: View {
    @Environment(MainViewModel.self) var vm
    @Environment(\.dismiss) private var dismiss
    
    // UX values
    @FocusState private var focusedField: Field?
    enum Field { case cals }
    
    // Views
    private var programSelection: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Mon programme")
                .font(.title2)
            GlassEffectContainer {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                    Button("Prise de masse") { vm.nutritionGoals.fitnessProgram = .gainMass }
                        .buttonStyle(CustomButtonStyle(state: vm.nutritionGoals.fitnessProgram == .gainMass ? .highlight : .normal, width: .full))
                    Button("Maintien") { vm.nutritionGoals.fitnessProgram = .maintain }
                        .buttonStyle(CustomButtonStyle(state: vm.nutritionGoals.fitnessProgram == .maintain ? .highlight : .normal, width: .full))
                    Button("Perte de poids") { vm.nutritionGoals.fitnessProgram = .loseWeight }
                        .buttonStyle(CustomButtonStyle(state: vm.nutritionGoals.fitnessProgram == .loseWeight ? .highlight : .normal, width: .full))
                }
                Button("Programme personnalisé") { vm.nutritionGoals.fitnessProgram = .custom }
                    .buttonStyle(CustomButtonStyle(state: vm.nutritionGoals.fitnessProgram == .custom ? .highlight : .normal, width: .full))
            }
        }
    }
    @ViewBuilder private var macronutrientsValues: some View {
    @Bindable var vm = vm
    
    VStack(alignment: .leading, spacing: 24) {
        Text("Valeurs")
            .font(.smallTitle)
        VStack {
            DataBox(label: "Apport calorique par jour", icon: vm.nutritionGoals.fitnessProgram == .custom ? .numbers : .none) {
                Group {
                    if vm.nutritionGoals.fitnessProgram == .custom {
                        TextField("", value: $vm.nutritionGoals.calsDaily, format: .number)
                    } else {
                        Text(vm.nutritionGoals.calsDaily.description)
                    }
                }
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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: vm.nutritionGoals.fitnessProgram == .custom ? 300: 100))], spacing: 16) {
                DataBox(label: "Glucides", icon: vm.nutritionGoals.fitnessProgram == .custom ? .slider : .none) {
                    Group {
                        if vm.nutritionGoals.fitnessProgram == .custom {
                            Slider(
                                value: Binding(
                                    get: { Double(vm.nutritionGoals.carbsPercentage) },
                                    set: { vm.nutritionGoals.carbsPercentage = Int($0) }
                                ),
                                in: 5...95,
                                step: 5
                            )
                            .padding(.trailing, 16)
                        }
                        VStack {
                            HStack(alignment: .bottom) {
                                Text(vm.nutritionGoals.carbsPercentage.description)
                                    .font(.cardData)
                                    .multilineTextAlignment(.trailing)
                                Text("%")
                                    .font(.cardUnit)
                                    .offset(y: -5)
                            }
                            Text(vm.nutritionGoals.carbsDaily.description + " cal")
                        }
                    }
                }
                DataBox(label: "Lipides", icon: vm.nutritionGoals.fitnessProgram == .custom ? .slider : .none) {
                    Group {
                        if vm.nutritionGoals.fitnessProgram == .custom {
                            Slider(
                                value: Binding(
                                    get: { Double(vm.nutritionGoals.fatsPercentage) },
                                    set: { vm.nutritionGoals.fatsPercentage = Int($0) }
                                ),
                                in: 5...95,
                                step: 5
                            )
                            .padding(.trailing, 16)
                        }
                        VStack {
                            HStack(alignment: .bottom) {
                                Text(vm.nutritionGoals.fatsPercentage.description)
                                    .font(.cardData)
                                    .multilineTextAlignment(.trailing)
                                Text("%")
                                    .font(.cardUnit)
                                    .offset(y: -5)
                            }
                            Text(vm.nutritionGoals.fatsDaily.description + " cal")
                        }
                    }
                }
                DataBox(label: "Protéines", icon: vm.nutritionGoals.fitnessProgram == .custom ? .slider : .none) {
                    Group {
                        if vm.nutritionGoals.fitnessProgram == .custom {
                            Slider(
                                value: Binding(
                                    get: { Double(vm.nutritionGoals.protsPercentage) },
                                    set: { vm.nutritionGoals.protsPercentage = Int($0) }
                                ),
                                in: 5...95,
                                step: 5
                            )
                            .padding(.trailing, 16)
                        }
                        VStack {
                            HStack(alignment: .bottom) {
                                Text(vm.nutritionGoals.protsPercentage.description)
                                    .font(.cardData)
                                    .multilineTextAlignment(.trailing)
                                Text("%")
                                    .font(.cardUnit)
                                    .offset(y: -5)
                            }
                            Text(vm.nutritionGoals.protsDaily.description + " cal")
                        }
                    }
                }
            }
            .onAppear() {
                vm.nutritionGoals.bmr = vm.user.bmr ?? 0
                vm.getRepartition()
            }
            
            .onChange(of: vm.nutritionGoals.fitnessProgram) {
                vm.getRepartition()
            }
            .onChange(of: vm.nutritionGoals.values) {
                vm.calculateDailyValues()
            }
        }
    }
}
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    
                    programSelection
                    macronutrientsValues
                    
                    ErrorMessage(message: vm.errorMessage)
                    
                }
                .padding()
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Mon programme diététique")
                        .font(.smallTitle)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .confirmationAction) {
                    Button("Valider", systemImage: "checkmark") {
                        Task {
                            if await vm.postNutritionGoals() {
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
    NutritionGoal().environment(MainViewModel())
}
