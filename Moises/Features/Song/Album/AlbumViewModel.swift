//
//  AlbumsViewModel.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import Foundation

final class AlbumViewModel: ObservableObject {
    
    @Published private(set) var songs: [SongModel] = []
    @Published private(set) var state = ViewState.idle

    private let repository: AlbumRepository
    
    var shouldShowLoadingView: Bool {
        state == .loading
    }

    init(repository: AlbumRepository = RemoteAlbumRepository()) {
        self.repository = repository
    }

    @MainActor
    func loadSongs(for collectionId: Int) {
        Task {
            do {
                state = .loading
                songs = try await repository.lookupSongsByAlbum(collectionId: collectionId).filter {$0.kind == "song"}.toModelList()
                state = .finished
            } catch {
                state = .error
            }
        }
    }
}
