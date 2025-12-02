//
//  FitnessView.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import SwiftUI

struct FitnessView: View {
    @Environment(MainViewModel.self) var vm

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        VStack(alignment: .leading) {
                            Text("Activités")
                                .font(.title2)
                                .foregroundStyle(Color.Label.primary)
                            Text("3 derniers jours")
                                .font(.callout2)
                                .foregroundStyle(Color.Label.tertiary)
                        }
                        GlassEffectContainer {
                            ForEach(vm.fitness.exercises) { exercise in
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
                        NavigationLink {
                            ExerciseListView().environment(vm)
                        } label: {
                            HStack {
                                Spacer()
                                Text("Historique des activités")
                                    .font(.caption)
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundStyle(Color.Label.secondary)
                        }
                    }
                }
                .padding()
            }
            .task {
                await vm.fetchExerciseTypes()
                await vm.fetchExercises(days: 3)
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Fitness")
                        .font(.title)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .confirmationAction) {
                    NavigationLink {
                        NewExerciseView().environment(vm)
                    } label: {
                        Label("Nouvelle activité", systemImage: "plus")
                            .tint(Color.Button.validate)
                    }
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
    FitnessView().environment(MainViewModel())
}
