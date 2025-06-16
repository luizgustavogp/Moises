//
//  MockFailingSongsRepository.swift
//  Moises
//
//  Created by Gustavo Guimarães on 15/06/25.
//

import Foundation
@testable import Moises

final class MockFailingSongsRepository: SongsRepository {
    func searchSongs(term: String, offset: Int, limit: Int) async throws -> [Song] {
        throw NSError(domain: "Test", code: 1, userInfo: nil)
    }
}
