//
//  LoginViewModel.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import Foundation

@Observable
class LoginViewModel {
    var errorMessage = ""
    
    func loginUser(_ email: String, _ password: String) async throws {
        let user = LoginRequest(email: email, password: password)
        guard let url = URL(string: "http://localhost:8080/users/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encodedData = try JSONEncoder().encode(user)
        request.httpBody = encodedData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    print("Login successful for user \(user.email) with token \(loginResponse.token)")
                } else {
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        errorMessage = "Login failed: \(errorResponse.reason)"
                    } else {
                        errorMessage = "Login failed: \(httpResponse.statusCode)"
                    }
                }
            }
        } catch {
            errorMessage = "Network error: \(error.localizedDescription)"
            print("Error: \(error)")
        }
    }
}
