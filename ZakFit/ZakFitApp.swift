//
//  ZakFitApp.swift
//  ZakFit
//
//  Created by Anne Ferret on 23/11/2025.
//

import SwiftUI

@main
struct ZakFitApp: App {
    var body: some Scene {
        WindowGroup {
            Group {
                if AuthManager.shared.isAuthenticated {
                    DashboardView()
                } else {
                    LoginView()
                }
            }
            .environment(AuthManager.shared)
        }
    }
}
