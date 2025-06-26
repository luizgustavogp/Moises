//
//  DSMQueuePlayback.swift
//  Moises
//
//  Created by Gustavo Guimarães on 22/06/25.
//

import Foundation



protocol DSMQueuePlayback {
    var current: DSMQueuePlaybackItem? { get }
    func playCurrent() -> DSMQueuePlaybackItem?
    func playNext() -> DSMQueuePlaybackItem?
    func playPreview() -> DSMQueuePlaybackItem?
    func clear()
}

final class DSMInMemoryQueuePlayback: DSMQueuePlayback {
    
    private var currentIndex: Int = 0
    private var tracks: [DSMQueuePlaybackItem]
    
    init(queue: [DSMQueuePlaybackItem]) {
        self.tracks = queue
    }
    
    var current: DSMQueuePlaybackItem? {
        tracks.isEmpty ? nil : tracks[currentIndex]
    }
    
    public func playCurrent() -> DSMQueuePlaybackItem? {
        return current
    }
    
    public func playNext() -> DSMQueuePlaybackItem? {
        guard currentIndex + 1 < tracks.count else { return nil}
        currentIndex += 1
        return current
    }
    
    public func playPreview() -> DSMQueuePlaybackItem? {
        guard currentIndex - 1 >= 0 else { return nil }
        currentIndex -= 1
        return current
    }
    
    public func clear() {
        tracks = []
        currentIndex = 0
    }
}
