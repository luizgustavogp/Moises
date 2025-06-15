//
//  SongModelMapper.swift
//  Moises
//
//  Created by Gustavo Guimarães on 15/06/25.
//

extension SongModel {
    init(from song: Song) {
        self.trackId = song.trackId
        self.artistName = song.artistName
        self.trackName = song.trackName
        self.artworkUrl100 = song.artworkUrl100
        self.collectionId = song.collectionId
        self.collectionName = song.collectionName
        self.trackTimeMillis = song.trackTimeMillis
    }
}

extension Array where Element == Song {
    func toModelList() -> [SongModel] {
        self.map(SongModel.init(from:))
    }
}
