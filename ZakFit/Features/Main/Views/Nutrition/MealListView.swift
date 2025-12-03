//
//  MealListView.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct MealListView: View {
    @Environment(MainViewModel.self) var vm
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        GlassEffectContainer {
                            ForEach(vm.nutrition.meals) { meal in
                                NavigationLink {
                                    MealDetailView(id: meal.id).environment(vm)
                                } label: {
                                    MealRow(
                                        name: meal.mealTypeName,
                                        date: meal.date,
                                        calories: meal.cals
                                    )
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .task {
                await vm.fetchMeals()
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Historique des repas")
                        .font(.smallTitle)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)
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
    MealListView().environment(MainViewModel())
}
