//
//  SongsViewModelTests.swift
//  MoisesTests
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import Combine
import Testing
@testable import Moises

@MainActor
struct SongsViewModelTests {
    
    // MARK: - Helpers
    
    func makeSUT(pageLimit: Int = 3, repository: SongsRepository) -> SongsViewModel<ImmediateScheduler> {
        SongsViewModel(pageLimit: pageLimit, scheduler: ImmediateScheduler.shared, repository: repository)
    }
    
    // MARK: - Tests
    
    @Test
    func testInitialState() {
        let sut = makeSUT(pageLimit: 5, repository: MockSongsRepository())
        
        #expect(sut.state == .idle)
        #expect(sut.songs.isEmpty)
        #expect(!sut.shouldShowEmptyState)
    }
    
    @Test
    func testLoadNextPageAppendsSongs() {
        let sut = makeSUT(pageLimit: 5, repository: MockSongsRepository(itemCount: 5))
        
        _ = sut.$searchTerm
            .dropFirst()
            .sink { _ in
                #expect(sut.songs.count == 5)
                #expect(sut.state == .idle)
            }
        
        sut.searchTerm = "Rock"
    }
    
    @Test
    func testPagination() {
        let sut = makeSUT(pageLimit: 3, repository: MockSongsRepository(itemCount: 6))
        
        _ = sut.$searchTerm
            .dropFirst()
            .sink { _ in
                Task {
                    await sut.loadNextPageIfNeeded(currentSong: sut.songs.last!)
                    #expect(sut.songs.count == 6)
                    #expect(sut.state == .idle)
                }
            }
        
        sut.searchTerm = "Rock"
    }
    
    @Test
    func testPaginationFinished() {
        let sut = makeSUT(pageLimit: 3, repository: MockSongsRepository(itemCount: 2))
        
        _ = sut.$searchTerm
            .dropFirst()
            .sink { _ in
                #expect(sut.songs.count == 2)
                #expect(sut.state == .finished)
            }
        
        sut.searchTerm = "Rock"
    }
    
    @Test
    func testEmptyStateVisibility() {
        let sut = makeSUT(repository: MockEmptySongsRepository())
        
        _ = sut.$searchTerm
            .dropFirst()
            .sink { _ in
                #expect(sut.shouldShowEmptyState)
            }
        
        sut.searchTerm = "Rock"
    }
    
    @Test
    func testErrorStateVisibility() {
        let sut = makeSUT(repository: MockFailingSongsRepository())
        
        _ = sut.$searchTerm
            .dropFirst()
            .sink { _ in
                #expect(sut.shouldShowErrorView)
            }
        
        sut.searchTerm = "Rock"
    }
    
    @Test
    func testRefreshClearsSongsAndReloads() {
        let sut = makeSUT(repository: MockSongsRepository(itemCount: 2))
        
        _ = sut.$searchTerm
            .dropFirst()
            .sink { _ in
                Task {
                    await sut.refresh()
                    #expect(sut.songs.count == 2)
                    #expect(sut.state == .finished)
                }
            }
        
        sut.searchTerm = "Rock"
    }
}
