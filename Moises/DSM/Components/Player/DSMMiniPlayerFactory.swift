//
//  DSMMiniPlayerFactory.swift
//  Moises
//
//  Created by Gustavo Guimarães on 22/06/25.
//

enum DSMMiniPlayerFactory {
    static func makeViewModel(for song: SongModel) -> DSMMiniPlayerControlViewModel {
        let item = DSMQueuePlaybackItem(from: song)
        let queue = DSMInMemoryQueuePlayback(queue: [item])
        let playerService = DSMMiniAvPlayerService(queuePlayback: queue)
        return DSMMiniPlayerControlViewModel(playerService: playerService)
    }
}
