//
//  SongArrayMappingTests.swift
//  Moises
//
//  Created by Gustavo Guimarães on 16/06/25.
//

import Testing
@testable import Moises

@Suite
struct SongArrayMappingTests {
    
    @Test
    func testEmptyListReturnsEmptyModelList() {
        // Arrange
        let emptySongs: [Song] = []
        
        // Act
        let models = emptySongs.toModelList()
        
        // Assert
        #expect(models.isEmpty)
    }
    
    @Test
    func testNonEmptyListReturnsMappedModelList() {
        // Arrange
        let songs: [Song] = [
            Song(
                trackId: 1,
                artistName: "Artist 1",
                trackName: "Track 1",
                artworkUrl100: "",
                collectionId: 100,
                collectionName: "Album 1",
                trackTimeMillis: 200_000,
                kind: "song",
                previewUrl: ""
            ),
            Song(
                trackId: 2,
                artistName: "Artist 2",
                trackName: "Track 2",
                artworkUrl100: "",
                collectionId: 200,
                collectionName: "Album 2",
                trackTimeMillis: 300_000,
                kind: "song",
                previewUrl: ""
            )
        ]
        
        // Act
        let models = songs.toModelList()
        
        // Assert
        #expect(models.count == 2)
    }
}
