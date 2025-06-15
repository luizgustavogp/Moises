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
    
    @Published var searchTerm: String = ""
    @Published private(set) var songs: [Song] = []
    @Published private(set) var state = ViewState.idle
    
    private var page = 0
    private let pageLimit: Int
    private let repository: SongsRepository
    private var cancellables = Set<AnyCancellable>()
    
    var shouldShowErrorView: Bool {
        state == .error
    }
    
    var shouldShowLoadingView: Bool {
        state == .loading
    }
    
    var shouldShowEmptyState: Bool {
        songs.isEmpty && state == .finished
    }
    
    init(searchTerm: String = "",
         pageLimit: Int = 30,
         repository: SongsRepository = RemoteSongsRepository()) {
        
        self.searchTerm = searchTerm
        self.pageLimit = pageLimit
        self.repository = repository
        
        initSearchTerm()
    }
    
    // MARK: Private methods
    private func initSearchTerm() {
        $searchTerm
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
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
        state = .idle
        page = 0
        songs = []
    }
    
    // MARK: Public  methods
    func loadNextPage(term: String) async {
        guard !term.isEmpty, state == .idle else { return }
        
        state = .loading
        
        do {
            let offset = page * pageLimit
            let newSongs = try await repository.searchSongs(term: term, offset: offset, limit: pageLimit)
            
            // Remove duplicated items based on trackId
            let uniqueNewSongs = newSongs.filter { newSong in
                !songs.contains(where: { $0.trackId == newSong.trackId })
            }
            
            page += 1
            songs.append(contentsOf: uniqueNewSongs)
            state = uniqueNewSongs.isEmpty || uniqueNewSongs.count < pageLimit ? .finished : .idle
            
        } catch {
            state = .error
        }
    }
    
    func loadNextPageIfNeeded(currentSong: Song) {
        guard currentSong.trackId == songs.last?.trackId else { return }
        
        Task {
            await loadNextPage(term: searchTerm)
        }
    }
    
    func refresh() {
        reset()
        Task {
            await loadNextPage(term: searchTerm)
        }
    }
}
