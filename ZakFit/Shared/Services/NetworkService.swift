//
//  NetworkService.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    private let baseURL = "http://localhost:8080"
    
    // MARK: - Generic Request Method
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        body: Encodable? = nil,
        requiresAuth: Bool = false
    ) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add authentication token if required
        if requiresAuth {
            if let token = try KeychainManager.shared.getToken() {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                throw NetworkError.unauthorized
            }
        }
        
        // Encode body if provided
        if let body = body {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try encoder.encode(body)
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Handle status codes
        switch httpResponse.statusCode {
        case 200...299:
            // Success - decode the response
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase  // Add this!
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    // MARK: - Convenience Methods
    
    func get<T: Decodable>(endpoint: String, requiresAuth: Bool = false) async throws -> T {
        return try await request(endpoint: endpoint, method: .get, requiresAuth: requiresAuth)
    }
    
    func post<T: Decodable>(endpoint: String, body: Encodable, requiresAuth: Bool = false) async throws -> T {
        return try await request(endpoint: endpoint, method: .post, body: body, requiresAuth: requiresAuth)
    }
    
    func patch<T: Decodable>(endpoint: String, body: Encodable, requiresAuth: Bool = true) async throws -> T {
        return try await request(endpoint: endpoint, method: .patch, body: body, requiresAuth: requiresAuth)
    }
    
    func delete<T: Decodable>(endpoint: String, requiresAuth: Bool = true) async throws -> T {
        return try await request(endpoint: endpoint, method: .delete, requiresAuth: requiresAuth)
    }
    
    // For requests that don't return data (like DELETE)
    func deleteNoResponse(endpoint: String, requiresAuth: Bool = true) async throws {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        if requiresAuth {
            if let token = try KeychainManager.shared.getToken() {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                throw NetworkError.unauthorized
            }
        }
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case unauthorized
    case serverError(statusCode: Int)
    case decodingError
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL invalide"
        case .invalidResponse:
            return "Réponse invalide du serveur"
        case .unauthorized:
            return "Identifiants incorrects"
        case .serverError(let statusCode):
            return "Erreur serveur: \(statusCode)"
        case .decodingError:
            return "Erreur de décodage"
        case .noData:
            return "Aucune donnée reçue"
        }
    }
}
