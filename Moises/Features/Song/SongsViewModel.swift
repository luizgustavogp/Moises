//
//  SongsViewModel.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import Combine
import Foundation

@MainActor
final class SongsViewModel<S: Scheduler>: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published private(set) var songs: [SongModel] = []
    @Published private(set) var state = ViewState.idle
    
    private var page = 0
    private let pageLimit: Int
    private let scheduler: S
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
    
    init(pageLimit: Int = 30,
         scheduler: S = RunLoop.main,
         repository: SongsRepository = RemoteSongsRepository()) {
        
        self.pageLimit = pageLimit
        self.scheduler = scheduler
        self.repository = repository
        
        initSearchTerm()
    }
    
    // MARK: Private methods
    private func initSearchTerm() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(1.5), scheduler: scheduler)
            .removeDuplicates()
            .sink { [weak self] term in
                guard let self = self else { return }
                
                Task {
                    self.reset()
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
    
    private func loadNextPage(term: String) async {
        guard !term.isEmpty, state == .idle else { return }
        
        state = .loading
        
        do {
            let offset = page * pageLimit
            let newSongs = try await repository.searchSongs(term: term, offset: offset, limit: pageLimit).toModelList()
            
            page += 1
            songs.append(contentsOf: newSongs)
            state = newSongs.isEmpty || newSongs.count < pageLimit ? .finished : .idle
            
        } catch {
            state = .error
            print(error.localizedDescription)
        }
    }
    
    // MARK: Public  methods
    
    func loadNextPageIfNeeded(currentSong: SongModel) async {
        guard currentSong.trackId == songs.last?.trackId else { return }
        await loadNextPage(term: searchTerm)
    }
    
    func refresh() async {
        guard state != .loading else { return }
        reset()
        await loadNextPage(term: searchTerm)
    }
}
