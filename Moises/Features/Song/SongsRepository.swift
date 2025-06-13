//
//  SongsRepository.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import Foundation

protocol SongsRepository: Sendable {
    func searchSongs(term: String, offset: Int, limit: Int) async throws -> [Song]
}

final class RemoteSongsRepository: SongsRepository {
    private let network: NetworkService

    init(network: NetworkService = DefaultNetworkService()) {
        self.network = network
    }

    func searchSongs(term: String, offset: Int = 0, limit: Int = 20) async throws -> [Song] {
        guard let query = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://itunes.apple.com/search?term=\(query)&media=music&limit=\(limit)&offset=\(offset)") else {
            return []
        }
        
        let response: SearchResponse<Song> = try await network.request(url)

        return response.results
    }
}

