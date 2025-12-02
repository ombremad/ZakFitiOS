//
//  NutritionGoal.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct NutritionGoal: View {
    @Environment(MainViewModel.self) var vm
    
    // Form values
    @State private var fitnessProgram: FitnessProgram = .custom
    @State private var bmr: Int = 0
    @State private var carbsPercentage: Int = 0
    @State private var fatsPercentage: Int = 0
    @State private var protsPercentage: Int = 0
    @State private var calsDaily: Int = 0
    @State private var carbsDaily: Int = 0
    @State private var fatsDaily: Int = 0
    @State private var protsDaily: Int = 0
//    @State private var nutritionValues: Int {
//        bmr + calsDaily + carbsPercentage + fatsPercentage + protsPercentage
//    }


    // UX values
    @FocusState private var focusedField: Field?
    enum Field { case cals }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    Text("Mon programme")
                        .font(.title2)
                    GlassEffectContainer {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                            Button("Prise de masse") { fitnessProgram = .gainMass }
                                .buttonStyle(CustomButtonStyle(state: fitnessProgram == .gainMass ? .highlight : .normal, width: .full))
                            Button("Maintien") { fitnessProgram = .maintain }
                                .buttonStyle(CustomButtonStyle(state: fitnessProgram == .maintain ? .highlight : .normal, width: .full))
                            Button("Perte de poids") { fitnessProgram = .loseWeight }
                                .buttonStyle(CustomButtonStyle(state: fitnessProgram == .loseWeight ? .highlight : .normal, width: .full))
                        }
                        Button("Programme personnalisé") { fitnessProgram = .custom }
                            .buttonStyle(CustomButtonStyle(state: fitnessProgram == .custom ? .highlight : .normal, width: .full))
                    }
                    Text("Valeurs")
                        .font(.smallTitle)
                    VStack {
                        DataBox(label: "Apport calorique par jour", icon: fitnessProgram == .custom ? .numbers : .none) {
                            Group {
                                if fitnessProgram == .custom {
                                    TextField("", value: $calsDaily, format: .number)
                                } else {
                                    Text(calsDaily.description)
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
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: fitnessProgram == .custom ? 300: 100))], spacing: 16) {
                            DataBox(label: "Glucides", icon: fitnessProgram == .custom ? .slider : .none) {
                                Group {
                                    if fitnessProgram == .custom {
                                        Slider(
                                            value: Binding(
                                                get: { Double(carbsPercentage) },
                                                set: { carbsPercentage = Int($0) }
                                            ),
                                            in: 5...95,
                                            step: 5
                                        )
                                        .padding(.trailing, 16)
                                    }
                                    VStack {
                                        HStack(alignment: .bottom) {
                                            Text(carbsPercentage.description)
                                                .font(.cardData)
                                                .multilineTextAlignment(.trailing)
                                            Text("%")
                                                .font(.cardUnit)
                                                .offset(y: -5)
                                        }
                                        Text(carbsDaily.description + " cal")
                                    }
                                }
                            }
                            DataBox(label: "Lipides", icon: fitnessProgram == .custom ? .slider : .none) {
                                Group {
                                    if fitnessProgram == .custom {
                                        Slider(
                                            value: Binding(
                                                get: { Double(fatsPercentage) },
                                                set: { fatsPercentage = Int($0) }
                                            ),
                                            in: 5...95,
                                            step: 5
                                        )
                                        .padding(.trailing, 16)
                                    }
                                    VStack {
                                        HStack(alignment: .bottom) {
                                            Text(fatsPercentage.description)
                                                .font(.cardData)
                                                .multilineTextAlignment(.trailing)
                                            Text("%")
                                                .font(.cardUnit)
                                                .offset(y: -5)
                                        }
                                        Text(fatsDaily.description + " cal")
                                    }
                                }
                            }
                            DataBox(label: "Protéines", icon: fitnessProgram == .custom ? .slider : .none) {
                                Group {
                                    if fitnessProgram == .custom {
                                        Slider(
                                            value: Binding(
                                                get: { Double(protsPercentage) },
                                                set: { protsPercentage = Int($0) }
                                            ),
                                            in: 5...95,
                                            step: 5
                                        )
                                        .padding(.trailing, 16)
                                    }
                                    VStack {
                                        HStack(alignment: .bottom) {
                                            Text(protsPercentage.description)
                                                .font(.cardData)
                                                .multilineTextAlignment(.trailing)
                                            Text("%")
                                                .font(.cardUnit)
                                                .offset(y: -5)
                                        }
                                        Text(protsDaily.description + " cal")
                                    }
                                }
                            }
                        }
                    }
//                    .onChange(of: fitnessProgram) {
//                        vm.getRepartition()
//                    }
//                    .onChange(of: nutritionValues) {
//                        vm.calculateDailyValues()
//                    }
                }
                .padding()
            }
            
            .task {
                bmr = vm.user.bmr ?? 0
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Mon programme diététique")
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
    NutritionGoal().environment(MainViewModel())
}
