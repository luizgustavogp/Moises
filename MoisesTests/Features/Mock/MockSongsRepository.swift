//
//  MockSongsRepository.swift
//  Moises
//
//  Created by Gustavo Guimarães on 15/06/25.
//

import Foundation
@testable import Moises

final class MockSongsRepository: SongsRepository {
    func searchSongs(term: String, offset: Int, limit: Int) async throws -> [Song] {
        (0..<limit).map { index in
            return Song(
                trackId: abs(UUID().hashValue),
                artistName: "Rock \(index)",
                trackName: "Legal \(index)",
                artworkUrl100: "",
                collectionId: 1,
                collectionName: "Brazilian rock",
                trackTimeMillis: 100,
                kind: "song")
        }
    }
}
