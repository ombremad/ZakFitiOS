//
//  TabContainer.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import SwiftUI

struct TabContainer: View {
    @State var vm = MainViewModel()
    
    var body: some View {
        VStack {
            TabView(selection: $vm.selectedTab) {
                ForEach(AppTab.allCases, id: \.self) { tab in
                    Tab(tab.title, systemImage: tab.icon, value: tab) {
                        tab.view(vm: vm)
                    }
                }
            }
        }
    }
}

#Preview {
    TabContainer()
}
