//
//  DashboardView.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import SwiftUI

struct DashboardView: View {
    @State var vm = LoginViewModel()
    var body: some View {
        VStack {
            Text("Connecté !")
            Button("Se déconnecter") {
                Task {
                    vm.logout()
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
