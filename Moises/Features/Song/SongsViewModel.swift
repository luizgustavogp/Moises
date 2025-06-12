//
//  SongsViewModel.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import Combine
import Foundation

@MainActor
final class SongsViewModel: ObservableObject {
    
    enum State: Comparable {
        case idle
        case loading
        case finished
        case error(String)
    }
    
    @Published var searchTerm: String = ""
    @Published var songs: [Song] = []
    @Published var state = State.idle
    
    private let debounceDelay = 1000
    
    private let limit = 20
    private var page = 0
    
    private let repository: SongsRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: SongsRepository = RemoteSongsRepository()) {
        self.repository = repository
        initSearchTerm()
    }
    
    //MARK: Private methods
    
    private func initSearchTerm() {
        $searchTerm
            .debounce(for: .milliseconds(debounceDelay), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] term in
                guard let self = self else { return }
                
                Task {
                    self.state = .idle
                    self.songs = []
                    await self.loadNextPage(term: term)
                }
            }
            .store(in: &cancellables)
    }
    
    private func reset() {
        page = 0
        songs = []
    }
    
    private func loadNextPage(term: String) async {
        guard !term.isEmpty else { return }
        
        guard state == .idle else { return }
        
        do {
            state = .loading
            let offset = page * limit
            let newSongs = try await repository.searchSongs(term: searchTerm, offset: offset, limit: limit)
            let uniqueNewSongs = newSongs.filter { newSong in
                !songs.contains(where: { $0.trackId == newSong.trackId })
            }
            
            songs.append(contentsOf: uniqueNewSongs)
            page += 1
            state = newSongs.count == limit ? .idle : .finished
            
            print("Loading data from page \(page) to \(offset)")
            
        } catch {
            state = .error("Something wents wrong. Please try again later.")
        }
    }
    
    //MARK: Public  methods
    func loadNextPageIfNeeded() {
        Task {
            await loadNextPage(term: searchTerm)
        }
    }
    
    func refresh() {
        guard !searchTerm.isEmpty else { return }
        reset()
        Task {
            await loadNextPage(term: searchTerm)
        }
    }
}
