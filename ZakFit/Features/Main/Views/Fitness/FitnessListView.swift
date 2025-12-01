//
//  FitnessListView.swift
//  ZakFit
//
//  Created by Anne Ferret on 01/12/2025.
//

import SwiftUI

struct FitnessListView: View {
    @Environment(MainViewModel.self) var vm
    
    // Filtering and sorting values
    @State private var selectedExerciseType: ExerciseType? = nil
    @State private var selectedLengthOption: LengthOption? = nil
    @State private var selectedDateOption: DateOption? = nil
    @State private var minLength: Int? = nil
    @State private var maxLength: Int? = nil
    @State private var days: Int? = nil
    
    private struct LengthOption: Identifiable, Hashable {
        let id = UUID()
        let label: String
        let shortLabel: String
        var minLength: Int? = nil
        var maxLength: Int? = nil
    }
    
    private let lengthOptions: [LengthOption] = [
        LengthOption(label: "< 5 minutes", shortLabel: "< 5 min", minLength: 0, maxLength: 5),
        LengthOption(label: "5 à 15 minutes", shortLabel: "5-15 min", minLength: 5, maxLength: 15),
        LengthOption(label: "15 à 30 minutes", shortLabel: "15-30 min", minLength: 15, maxLength: 30),
        LengthOption(label: "30 minutes à 1 heure", shortLabel: "30 min-1h", minLength: 30, maxLength: 60),
        LengthOption(label: "> 1 heure", shortLabel: "> 1h", minLength: 60)
    ]
    
    private struct DateOption: Identifiable, Hashable {
        let id = UUID()
        let label: String
        var days: Int? = nil
    }
    
    private let dateOptions: [DateOption] = [
        DateOption(label: "Aujourd'hui", days: 1),
        DateOption(label: "Cette semaine", days: 7),
        DateOption(label: "Ce mois", days: 30),
        DateOption(label: "Ce trimestre", days: 90),
        DateOption(label: "Cette année", days: 365),
    ]
    
    // Helper functions
    private func reset() {
        selectedExerciseType = nil
        selectedLengthOption = nil
        selectedDateOption = nil
        minLength = nil
        maxLength = nil
        days = nil
    }
    
    private func fetchExercisesWithFilters() async {
        await vm.fetchExercises(
            exerciseType: selectedExerciseType?.id,
            minLength: minLength,
            maxLength: maxLength,
            days: days
        )
    }
        
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    VStack {
                        HStack {
                            Text("Filtres")
                                .font(.smallTitle)
                                .foregroundStyle(Color.Label.secondary)
                            Spacer()
                            Button("réinitialiser") {
                                Task {
                                    reset()
                                    await vm.fetchExercises()
                                }
                            }
                            .font(.caption)
                            .foregroundStyle(Color.Label.tertiary)
                        }
                        
                        GlassEffectContainer {
                            HStack {
                                Menu {
                                    Picker("Activité", selection: $selectedExerciseType) {
                                        ForEach(vm.exerciseTypes) { exerciseType in
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
                                    SortingBox(label: "Activité", value: selectedExerciseType?.name)
                                }
                                                                
                                Menu {
                                    Picker("Durée", selection: $selectedLengthOption) {
                                        ForEach(lengthOptions) { option in
                                            Text(option.label).tag(option as LengthOption?)
                                        }
                                    }
                                } label: {
                                    SortingBox(label: "Durée", value: selectedLengthOption?.shortLabel)
                                }
                                
                                Menu {
                                    Picker("Date", selection: $selectedDateOption) {
                                        ForEach(dateOptions) { option in
                                            Text(option.label).tag(option as DateOption?)
                                        }
                                    }
                                } label: {
                                    SortingBox(label: "Date", value: selectedDateOption?.label)
                                }


                            }
                        }
                    }
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        GlassEffectContainer {
                            ForEach(vm.exercises) { exercise in
                                ExerciseRow(
                                    name: exercise.exerciseType.name,
                                    icon: exercise.exerciseType.icon,
                                    level: exercise.exerciseType.level,
                                    date: exercise.date,
                                    length: exercise.length,
                                    calories: exercise.cals
                                )
                            }
                        }
                    }
                }
                .padding()
            }
            .task {
                await vm.fetchExercises()
            }
            .onChange(of: selectedExerciseType) { _, _ in
                Task { await fetchExercisesWithFilters() }
            }
            .onChange(of: selectedLengthOption) { _, newValue in
                minLength = newValue?.minLength
                maxLength = newValue?.maxLength
                Task { await fetchExercisesWithFilters() }
            }
            .onChange(of: selectedDateOption) { _, newValue in
                days = newValue?.days
                Task { await fetchExercisesWithFilters() }
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Historique des activités")
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

#Preview {
    FitnessListView().environment(MainViewModel())
}
