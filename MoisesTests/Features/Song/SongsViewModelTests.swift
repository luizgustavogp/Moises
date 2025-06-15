//
//  SongsViewModelTests.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import Foundation
import Testing
@testable import Moises


@MainActor
struct SongsViewModelTests {
    
    @Test
    func testInitialState() throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 5, repository: MockSongsRepository())
        
        // Assert
        #expect(sut.state == .idle)
        #expect(sut.songs.isEmpty)
        #expect(sut.shouldShowEmptyState == false)
    }
    
    @Test
    func testLoadNextPageAppendsSongs() async throws {
        // Arrange
        let searchTerm = "rock"
        let sut = SongsViewModel(searchTerm: searchTerm, pageLimit: 5, repository: MockSongsRepository())
        
        // Act
        await sut.loadNextPage(term: searchTerm)
        
        // Assert
        #expect(sut.songs.count == 5)
        #expect(sut.state == .idle || sut.state == .finished)
    }
    
    @Test
    func testPagination() async throws {
        // Arrange
        let searchTerm = "rock"
        let sut = SongsViewModel(searchTerm: searchTerm, pageLimit: 3, repository: MockSongsRepository())
        
        // Act
        await sut.loadNextPage(term: searchTerm)
        sut.loadNextPageIfNeeded(currentSong: sut.songs.last!)
        
        // Assert
        #expect(sut.songs.count == 6)
    }
    
    @Test
    func testEmptyStateVisibility() async throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 5, repository: MockEmptySongsRepository())
        
        // Act
        await sut.loadNextPage(term: "empty")
        
        // Assert
        #expect(sut.shouldShowEmptyState)
    }
    
    @Test
    func testErrorStateVisibility() async throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 5, repository: MockFailingSongsRepository())
        
        // Act
        await sut.loadNextPage(term: "fail")
        
        // Assert
        #expect(sut.shouldShowErrorView)
    }
}


// MARK: - Mocks
struct MockSongsRepository: SongsRepository {
    func searchSongs(term: String, offset: Int, limit: Int) async throws -> [Song] {
        (0..<limit).map { _ in Song.preview }
    }
}


struct MockEmptySongsRepository: SongsRepository {
    func searchSongs(term: String, offset: Int, limit: Int) async throws -> [Song] {
        []
    }
}

struct MockFailingSongsRepository: SongsRepository {
    func searchSongs(term: String, offset: Int, limit: Int) async throws -> [Song] {
        throw NSError(domain: "Test", code: 1, userInfo: nil)
    }
}

