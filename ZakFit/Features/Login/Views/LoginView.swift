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
    @State private var formData = LoginFormData()
    
    // UX values
    @FocusState private var focusedField: Field?
    enum Field { case firstName, lastName, email, password, passwordConfirmation }
    
    var body: some View {
        NavigationStack {
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
                                    .focused($focusedField, equals: .firstName)
                                TextField("Nom", text: $formData.lastName)
                                    .textContentType(.familyName)
                                    .submitLabel(.next)
                                    .focused($focusedField, equals: .lastName)
                            }
                            TextField("E-mail", text: $formData.email)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .submitLabel(.next)
                                .focused($focusedField, equals: .email)
                            
                            SecureField("Mot de passe", text: $formData.password)
                                .textContentType(vm.formState == .login ? .password : .newPassword)
                                .submitLabel(vm.formState == .login ? .send : .next)
                                .focused($focusedField, equals: .password)
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
                                    .submitLabel(.send)
                                    .focused($focusedField, equals: .passwordConfirmation)
                                    .onSubmit {
                                        if vm.formState == .signup {
                                            Task {
                                                await vm.signup(formData: formData)
                                            }
                                        }
                                    }
                            }
                            
                            ErrorMessage(message: vm.errorMessage)
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
                                withAnimation { vm.formState = .signup }
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
                                withAnimation { vm.formState = .login }
                            }
                            .buttonStyle(CustomButtonStyle(state: .normal))
                        }
                        
                    }
                    Spacer()
                }
            .navigationDestination(isPresented: $vm.showOnboarding) {
                OnboardingView(userData: formData)
            }
            .padding()
            .textFieldStyle(CustomTextFieldStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                LinearGradient.primary
                    .ignoresSafeArea()
                    .onTapGesture {
                        focusedField = nil
                    }
            }
        }
    }
}

#Preview {
    LoginView()
}
