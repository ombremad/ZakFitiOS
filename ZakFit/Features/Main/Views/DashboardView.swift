//
//  DashboardView.swift
//  ZakFit
//
//  Created by Anne Ferret on 27/11/2025.
//

import SwiftUI

struct DashboardView: View {
    @Environment(MainViewModel.self) var vm

    var body: some View {
        NavigationStack {
            ScrollView {
                Button("Se déconnecter") {
                    Task {
                        vm.logout()
                    }
                }
            }
                        
            .task {
                await vm.fetchUserData()
            }
            
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Aujourd'hui")
                        .font(.title)
                        .foregroundStyle(Color.Label.primary)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        UserSettingsView().environment(vm)
                    } label: {
                    HStack {
                        Text(vm.user.firstName ?? "undefined")
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)
                    }
                    .font(.caption)
                    .foregroundStyle(Color.Label.secondary)
                    }
                }
                .sharedBackgroundVisibility(.hidden)
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.App.background
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    DashboardView().environment(MainViewModel())
}
