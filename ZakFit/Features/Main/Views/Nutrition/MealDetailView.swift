//
//  MealDetailView.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct MealDetailView: View {
    @Environment(MainViewModel.self) var vm
    let id: UUID
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("a")
                }
                .padding()
            }
            .task {
                await vm.fetchMealDetail(id: id)
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text(vm.meal.mealType?.name ?? "undefined")
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
    MealDetailView(id: UUID(uuidString: "61EF3CDA-0BA1-48A5-A0C0-A1BBE6845DC5")!)
}
