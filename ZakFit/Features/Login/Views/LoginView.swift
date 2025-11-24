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
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(.logotypeMono)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128)
                
                VStack {
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        TextField("E-mail", text: $email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .submitLabel(.next)
                            .onChange(of: email) {
                                vm.clearError()
                            }

                        SecureField("Mot de passe", text: $password)
                            .textContentType(.password)
                            .submitLabel(.go)
                            .onChange(of: password) {
                                vm.clearError()
                            }
                            .onSubmit {
                                Task {
                                    await vm.login(email: email, password: password)
                                }
                            }
                        
                        if !vm.errorMessage.isEmpty {
                            Text(vm.errorMessage)
                                .foregroundStyle(.red)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }

                        Button("Connexion") {
                            Task {
                                await vm.login(email: email, password: password)
                            }
                        }
                        .disabled(vm.isLoading || email.isEmpty || password.isEmpty)
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
