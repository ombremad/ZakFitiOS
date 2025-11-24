//
//  LoginView.swift
//  ZakFit
//
//  Created by Anne Ferret on 23/11/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = "email"
    @State private var password: String = "password"
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(.logotypeMono)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button("Envoyer") {}
            }
            .padding()
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
