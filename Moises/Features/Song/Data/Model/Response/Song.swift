//
//  Song.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import Foundation

struct Song: Decodable, Hashable {
    let trackId: Int?
    let artistName: String
    let trackName: String?
    let artworkUrl100: String
    let collectionId: Int
    let collectionName: String?
    let trackTimeMillis: Int?
    let kind: String?
}
