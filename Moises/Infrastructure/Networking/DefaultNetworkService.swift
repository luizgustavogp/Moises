//
//  DefaultNetworkService.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import Foundation

import Foundation

final class DefaultNetworkService: NetworkService {
    
    func request<T: Decodable>(_ url: URL, retries: Int = 2) async throws -> T {
        var attempt = 0
        var lastError: Error?
        
        while attempt <= retries {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch {
                lastError = error
                attempt += 1
            }
        }
        
        throw lastError ?? URLError(.unknown)
    }
}
