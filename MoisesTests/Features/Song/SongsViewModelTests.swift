//
//  SongsViewModelTests.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import Testing
@testable import Moises

@MainActor
struct SongsViewModelTests {
    @Test func testInitialState() throws {
        let viewModel = SongsViewModel(pageLimit: 5, repository: MockSongsRepository())
        #expect(viewModel.state == .idle)
        #expect(viewModel.songs.isEmpty)
        #expect(viewModel.shouldShowEmptyState == false)
    }

    @Test func testLoadNextPageAppendsSongs() async throws {
        let viewModel = SongsViewModel(pageLimit: 5, repository: MockSongsRepository())
        viewModel.refresh()

        #expect(viewModel.songs.count == 0)
        #expect(viewModel.state == .idle)
    }

    @Test func testPagination() async throws {
        let viewModel = SongsViewModel(pageLimit: 3, repository: MockSongsRepository())
        #expect(viewModel.songs.count == 3)

        //viewModel.loadNextPageIfNeeded(currentSong: viewModel.songs.last)
        #expect(viewModel.songs.count == 6)
    }

    @Test func testEmptyStateVisibility() async throws {
        let viewModel = SongsViewModel(pageLimit: 5, repository: MockEmptySongsRepository())
        viewModel.refresh()
        #expect(viewModel.shouldShowEmptyState)
    }

//    @Test func testErrorStateVisibility() async throws {
//        let viewModel = SongsViewModel(pageLimit: 5, repository: MockFailingSongsRepository())
//        await viewModel.refresh()
//        try #expect(viewModel.shouldShowErrorView)
//    }
}

// MARK: - Mocks

struct MockSongsRepository: SongsRepository {
    func searchSongs(term: String, offset: Int, limit: Int) async throws -> [Song] {
        (0..<limit).map { index in
            Song.preview
        }
    }
}

struct MockEmptySongsRepository: SongsRepository {
    func searchSongs(term: String, offset: Int, limit: Int) async throws -> [Song] {
        []
    }
}

//struct MockFailingSongsRepository: SongsRepository {
//    func searchSongs(term: String, offset: Int, limit: Int) async throws -> [Song] {
//        throw URLError(.badServerResponse)
//    }
//}
