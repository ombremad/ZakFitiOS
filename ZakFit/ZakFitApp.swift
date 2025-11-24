//
//  ZakFitApp.swift
//  ZakFit
//
//  Created by Anne Ferret on 23/11/2025.
//

import SwiftUI

@main
struct ZakFitApp: App {
    @State private var authManager = AuthManager.shared

    var body: some Scene {
        WindowGroup {
            Group {
                if authManager.isAuthenticated {
                    DashboardView()
                } else {
                    LoginView()
                }
            }
            .environment(authManager)
        }
    }
}
