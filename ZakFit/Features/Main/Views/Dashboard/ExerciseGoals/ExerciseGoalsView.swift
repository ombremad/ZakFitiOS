//
//  ExerciseGoalsView.swift
//  ZakFit
//
//  Created by Anne Ferret on 03/12/2025.
//

import SwiftUI

struct ExerciseGoalsView: View {
    @Environment(MainViewModel.self) var vm

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    Text("Mes entraînements")
                        .font(.title2)
                        .foregroundStyle(Color.Label.primary)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(vm.exerciseGoals.goals) { goal in
                            GoalExerciseRow(
                                name: goal.exerciseType.name,
                                icon: goal.exerciseType.icon,
                                level: goal.exerciseType.level,
                                frequency: goal.frequency,
                                length: goal.length ?? nil,
                                cals: goal.cals ?? nil
                            )
                            .contextMenu {
                                Button(role: .destructive) {
                                    Task {
                                        if await vm.deleteExerciseGoal(goal.id) {
                                            await vm.fetchExerciseGoals()
                                        }
                                    }
                                } label: {
                                    Label("Supprimer", systemImage: "trash")
                                }
                            }
                        }
                    }
                    
                }
                .padding()
            }
            
            .task {
                await vm.fetchExerciseGoals()
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Mon programme physique")
                        .font(.smallTitle)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .confirmationAction) {
                    NavigationLink {
                        NewExerciseGoalView().environment(vm)
                    } label: {
                        Label("Nouvel objectif", systemImage: "plus")
                            .tint(Color.Button.validate)
                    }
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
    ExerciseGoalsView().environment(MainViewModel())
}
