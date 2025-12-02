//
//  NewMealView.swift
//  ZakFit
//
//  Created by Anne Ferret on 02/12/2025.
//

import SwiftUI

struct NewMealView: View {
    @Environment(MainViewModel.self) var vm
    
    var body: some View {
        Text("New Meal View")
    }
}

#Preview {
    NewMealView().environment(MainViewModel())
}
