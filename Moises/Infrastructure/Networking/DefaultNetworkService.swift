//
//  DefaultNetworkService.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import Foundation

final class DefaultNetworkService: NetworkService {
    func request<T: Decodable>(_ url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}
