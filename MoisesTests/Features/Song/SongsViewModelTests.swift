//
//  SongsViewModelTests.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import Combine
import Foundation
import XCTest
@testable import Moises

@MainActor
final class SongsViewModelTests: XCTestCase {
    
    func testInitialState() throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 5, repository: MockSongsRepository())
        
        // Assert
        XCTAssertEqual(sut.state, .idle)
        XCTAssertTrue(sut.songs.isEmpty)
        XCTAssertFalse(sut.shouldShowEmptyState)
    }
    
    func testLoadNextPageAppendsSongs() async throws {
        // Arrange
        let expectation = XCTestExpectation(description: "Songs loaded")
        let sut = SongsViewModel(pageLimit: 5, repository: MockSongsRepository())
        
        // Act
        sut.searchTerm = "Rock"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            // Assert
            XCTAssertEqual(sut.songs.count, 5)
            XCTAssertEqual(sut.state, .idle)
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    func testPagination() async throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 3, repository: MockSongsRepository())
        
        // Act
        sut.searchTerm = "Rock"
        try await Task.sleep(nanoseconds: 1_100_000_000)
        sut.loadNextPageIfNeeded(currentSong: sut.songs.last ?? Song.preview)
        try await Task.sleep(nanoseconds: 1_100_000_000)
        
        XCTAssertEqual(sut.songs.count, 6)
    }
    
    func testEmptyStateVisibility() async throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 5, repository: MockEmptySongsRepository())
        
        // Act
        sut.searchTerm = "Rock"
        
        // Assert
        XCTAssertTrue(sut.shouldShowEmptyState)
    }
    
    func testErrorStateVisibility() async throws {
        // Arrange
        let sut = SongsViewModel(pageLimit: 5, repository: MockFailingSongsRepository())
        
        // Act
        sut.searchTerm = "Rock"
        try await Task.sleep(nanoseconds: 1_100_000_000) // debounce delay
        
        // Assert
        XCTAssertTrue(sut.shouldShowErrorView)
    }
}


// MARK: - Mocks
struct MockSongsRepository: SongsRepository {
    func searchSongs(term: String, offset: Int, limit: Int) async throws -> [Song] {
        (0..<limit).map { index in
            return Song(
                trackId: abs(UUID().hashValue),
                artistName: "Rock \(index)",
                trackName: "Legal \(index)",
                artworkUrl100: "",
                collectionId: 1,
                collectionName: "Greatest Hits",
                trackTimeMillis: 1_000_000,
                kind: "song")
        }
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

