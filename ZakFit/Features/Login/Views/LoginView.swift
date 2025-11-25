//
//  LoginView.swift
//  ZakFit
//
//  Created by Anne Ferret on 23/11/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var vm = LoginViewModel()

    // form values
    @State private var formData = FormData()
        
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    Spacer()
                    Image(.logotypeMono)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 128)
                    
                    VStack(spacing: 8) {
                        if vm.isLoading {
                            ProgressView()
                        } else {
                            if vm.formState == .signup {
                                TextField("Prénom", text: $formData.firstName)
                                    .textContentType(.givenName)
                                    .submitLabel(.next)
                                TextField("Nom", text: $formData.lastName)
                                    .textContentType(.familyName)
                                    .submitLabel(.next)
                            }
                            TextField("E-mail", text: $formData.email)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .submitLabel(.next)
                            
                            SecureField("Mot de passe", text: $formData.password)
                                .textContentType(vm.formState == .login ? .password : .newPassword)
                                .submitLabel(vm.formState == .login ? .go : .next)
                                .onSubmit {
                                    if vm.formState == .login {
                                        Task {
                                            await vm.login(formData: formData)
                                        }
                                    }
                                }
                            
                            if vm.formState == .signup {
                                SecureField("Confirmer le mot de passe", text: $formData.passwordConfirmation)
                                    .textContentType(.newPassword)
                                    .submitLabel(.go)
                                    .onSubmit {
                                        Task {
                                            await vm.signup(formData: formData)
                                        }
                                    }
                            }
                            
                            if !vm.errorMessage.isEmpty {
                                Text(vm.errorMessage)
                                    .foregroundStyle(Color.Label.secondary)
                                    .font(.callout)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    
                    VStack(spacing: 8) {
                        
                        if vm.formState == .login {
                            Button("Se connecter") {
                                Task {
                                    await vm.login(formData: formData)
                                }
                            }
                            .buttonStyle(CustomButtonStyle(state: .validate))
                            Button("Pas encore de compte ?") {
                                vm.formState = .signup
                            }
                            .buttonStyle(CustomButtonStyle(state: .normal))
                            
                        } else if vm.formState == .signup {
                            Button("S'inscrire") {
                                Task {
                                    await vm.signup(formData: formData)
                                }
                            }
                            .buttonStyle(CustomButtonStyle(state: .validate))
                            Button("J'ai déjà un compte") {
                                vm.formState = .login
                            }
                            .buttonStyle(CustomButtonStyle(state: .normal))
                        }
                        
                    }
                    Spacer()
                }
                .padding()
                .textFieldStyle(CustomTextFieldStyle())
            }
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
