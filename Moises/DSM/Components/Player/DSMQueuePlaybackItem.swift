//
//  DSMQueuePlaybackItem.swift
//  Moises
//
//  Created by Gustavo Guimarães on 23/06/25.
//

import Foundation

struct DSMQueuePlaybackItem {
    let artist: String
    let collection: String?
    var duration: Double
    var url: URL?
}

extension DSMQueuePlaybackItem {
    init (from song: SongModel) {
        self.artist = song.artistName
        self.collection =  song.collectionName
        self.duration = 30.0
        self.url = song.previewUrl?.toURL()
    }
}
