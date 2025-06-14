//
//  Song.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import Foundation

struct Song: Decodable, Identifiable, Hashable {
    let trackId: Int?
    var id: Int { trackId ?? collectionId }
    let artistName: String
    let trackName: String?
    let artworkUrl100: String
    let collectionId: Int
    let collectionName: String?
    let trackTimeMillis: Int?
    let kind: String?
}

extension Song {
    static let preview = Song(
        trackId: UUID().hashValue,
        artistName: "Luiz",
        trackName: "Legal",
        artworkUrl100: "",
        collectionId: 1,
        collectionName: "Greatest Hits",
        trackTimeMillis: 1_000_000,
        kind: "song"
    )
}
