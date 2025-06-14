//
//  MockNetworkService.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import Foundation
@testable import Moises

final class MockNetworkService: NetworkService {
    let mockData: Data?
    let error: Error?

    init(mockData: Data? = nil, error: Error? = nil) {
        self.mockData = mockData
        self.error = error
    }

    func request<T: Decodable>(_ url: URL) async throws -> T {
        if let error = error {
            throw error
        }

        guard let data = mockData else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
