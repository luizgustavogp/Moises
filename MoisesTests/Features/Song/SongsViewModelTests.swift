//
//  SongsViewModelTests.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import Combine
import Foundation
import Testing
@testable import Moises

@MainActor
struct SongsViewModelTests {
    
    @Test
    func testInitialState() throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 5, debounceFor: .zero, repository: MockSongsRepository())
        
        // Assert
        #expect(sut.state == .idle)
        #expect(sut.songs.isEmpty)
        #expect(sut.shouldShowEmptyState == false)
    }
    
    @Test
    func testLoadNextPageAppendsSongs() async throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 5, debounceFor: .zero, repository: MockSongsRepository())
        
        // Act
        sut.searchTerm = "Rock"
        
        // Assert
        #expect(sut.songs.count == 5)
        #expect(sut.state == .idle)
    }
    
    @Test
    func testPagination() async throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 3, debounceFor: .zero, repository: MockSongsRepository())
        
        // Act
        sut.searchTerm = "Rock"
        await sut.loadNextPageIfNeeded(currentSong: sut.songs.last ?? SongModel.preview)
        
        // Assert
        #expect(sut.songs.count == 6)
    }
    
    @Test
    func testEmptyStateVisibility() async throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 5, repository: MockEmptySongsRepository())
        
        // Act
        sut.searchTerm = "Rock"
        
        // Assert
        #expect(sut.shouldShowEmptyState)
    }
    
    @Test
    func testErrorStateVisibility() async throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 5, repository: MockFailingSongsRepository())
        
        // Act
        sut.searchTerm = "Rock"
        
        // Assert
        #expect(sut.shouldShowErrorView)
    }
}
