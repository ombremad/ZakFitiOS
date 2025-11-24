//
//  LoginView.swift
//  ZakFit
//
//  Created by Anne Ferret on 23/11/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var vm = LoginViewModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isConnecting: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(.logotypeMono)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128)
                VStack {
                    if isConnecting {
                        ProgressView()
                    } else {
                        TextField("E-mail", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                        SecureField("Mot de passe", text: $password)
                        Text(vm.errorMessage)
                        Button("Connexion") {
                            Task {
                                isConnecting = true
                                vm.errorMessage = ""
                                try await vm.loginUser(email, password)
                                isConnecting = false
                            }
                        }
                    }
                }
                .frame(maxHeight: 300)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                LinearGradient.primary
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    LoginView()
}
