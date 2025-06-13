//
//  AlbumRepository.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import Foundation

protocol AlbumRepository {
    func lookupSongsByAlbum(collectionId: Int) async throws -> [Song]
}

final class RemoteAlbumRepository: AlbumRepository {
    private let network: NetworkService

    init(network: NetworkService = DefaultNetworkService()) {
        self.network = network
    }

    func lookupSongsByAlbum(collectionId: Int) async throws -> [Song] {
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song") else {
            return []
        }

        let response: SearchResponse<Song> = try await network.request(url)

        return response.results
    }
}
