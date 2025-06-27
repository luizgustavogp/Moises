//
//  SongModel.swift
//  Moises
//
//  Created by Gustavo Guimarães on 15/06/25.
//

import Foundation

struct SongModel: Identifiable, Hashable {
    let trackId: Int?
    let id = abs(UUID().hashValue)
    let artistName: String
    let trackName: String?
    let artworkUrl100: String
    let collectionId: Int
    let collectionName: String?
    let trackTimeMillis: Int?
    let previewUrl: String?
}

extension SongModel {
    static let preview = SongModel(
        trackId: UUID().hashValue,
        artistName: "Rock",
        trackName: "Legal",
        artworkUrl100: "",
        collectionId: 1,
        collectionName: "Greatest Hits",
        trackTimeMillis: 1_000_000,
        previewUrl: ""
    )
}
