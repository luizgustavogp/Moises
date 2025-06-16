//
//  MockEmptySongsRepository.swift
//  Moises
//
//  Created by Gustavo Guimarães on 15/06/25.
//

import Foundation
@testable import Moises

final class MockEmptySongsRepository: SongsRepository {
    func searchSongs(term: String, offset: Int, limit: Int) async throws -> [Song] {
        []
    }
}
