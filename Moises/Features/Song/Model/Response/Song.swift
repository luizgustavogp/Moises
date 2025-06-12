//
//  Song.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

struct Song: Decodable, Identifiable {
    let trackId: Int
    var id: Int { trackId }
    let artistName: String
    let trackName: String
    let artworkUrl100: String
    let previewUrl: String?
    let collectionName: String
    let trackTimeMillis: Int?
}

extension Song {
    static let preview = Song(
        trackId: 123,
        artistName: "Luiz",
        trackName: "Legal",
        artworkUrl100: "",
        previewUrl: "",
        collectionName: "Greatest Hits",
        trackTimeMillis: 1_000_000
    )
}
