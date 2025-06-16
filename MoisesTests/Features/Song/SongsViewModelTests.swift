//
//  SongsViewModelTests.swift
//  MoisesTests
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import XCTest
@testable import Moises

@MainActor
final class SongsViewModelTests: XCTestCase {
    
    // MARK: - Helpers
    
    private let shortDelay: TimeInterval = 0.1
    
    func after(_ delay: TimeInterval = 0.1, fulfill expectation: XCTestExpectation? = nil, _ block: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            block()
            expectation?.fulfill()
        }
    }
    
    func makeSUT(pageLimit: Int = 3, repository: SongsRepository) -> SongsViewModel {
        SongsViewModel(pageLimit: pageLimit, debounceFor: .zero, repository: repository)
    }
    
    // MARK: - Tests
    
    func testInitialState() {
        // Arrange
        let sut = makeSUT(pageLimit: 5, repository: MockSongsRepository())
        
        // Assert
        XCTAssertEqual(sut.state, .idle)
        XCTAssertTrue(sut.songs.isEmpty)
        XCTAssertFalse(sut.shouldShowEmptyState)
    }
    
    func testLoadNextPageAppendsSongs() {
        // Arrange
        let expectation = expectation(description: "Songs should be loaded into ViewModel")
        let sut = makeSUT(pageLimit: 5, repository: MockSongsRepository(itemCount: 5))
        
        // Act
        sut.searchTerm = "Rock"
        
        // Assert
        after(fulfill: expectation) {
            XCTAssertEqual(sut.songs.count, 5)
            XCTAssertEqual(sut.state, .idle)
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testPagination() {
        // Arrange
        let expectation = expectation(description: "Pagination should complete with 6 songs")
        let sut = makeSUT(pageLimit: 3, repository: MockSongsRepository())
        
        // Act
        sut.searchTerm = "Rock"
        
        after {
            Task {
                await sut.loadNextPageIfNeeded(currentSong: sut.songs.last!)
                
                // Assert
                self.after(fulfill: expectation) {
                    XCTAssertEqual(sut.songs.count, 6)
                    XCTAssertEqual(sut.state, .idle)
                }
            }
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testPaginationFinished() {
        // Arrange
        let expectation = expectation(description: "Pagination should finish after 2 items")
        let sut = makeSUT(pageLimit: 3, repository: MockSongsRepository(itemCount: 2))
        
        // Act
        sut.searchTerm = "Rock"
        
        // Assert
        after(fulfill: expectation) {
            XCTAssertEqual(sut.songs.count, 2)
            XCTAssertEqual(sut.state, .finished)
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testEmptyStateVisibility() {
        // Arrange
        let expectation = expectation(description: "Empty state should be visible")
        let sut = makeSUT(repository: MockEmptySongsRepository())
        
        // Act
        sut.searchTerm = "Rock"
        
        // Assert
        after(fulfill: expectation) {
            XCTAssertTrue(sut.shouldShowEmptyState)
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testErrorStateVisibility() {
        // Arrange
        let expectation = expectation(description: "Error state should be visible")
        let sut = makeSUT(repository: MockFailingSongsRepository())
        
        // Act
        sut.searchTerm = "Rock"
        
        // Assert
        after(fulfill: expectation) {
            XCTAssertTrue(sut.shouldShowErrorView)
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
