//
//  DSMMiniPlayerService.swift
//  Moises
//
//  Created by Gustavo Guimarães on 22/06/25.
//

import Combine
import AVFoundation

protocol DSMMiniPlayerService {
    func pause()
    func playCurrent()
    func playNext()
    func playPrevious()
    func currentTime() -> Double
    func getDuration() -> Double
    func seek(to time: Double)
    func stop()
    
    var currentTimePublisher: AnyPublisher<Double, Never> { get }
}

final class DSMMiniAvPlayerService: DSMMiniPlayerService {
    
    private var timeObserver: Any?
    private let player: AVPlayer
    private let queuePlayback: DSMQueuePlayback
    private var currentlyPlayingItem: DSMQueuePlaybackItem?
    
    private let currentTimeSubject = PassthroughSubject<Double, Never>()
    var currentTimePublisher: AnyPublisher<Double, Never> {
        currentTimeSubject.eraseToAnyPublisher()
    }
    
    init(player: AVPlayer = AVPlayer(),
         queuePlayback: DSMQueuePlayback = DSMInMemoryQueuePlayback(queue: [])) {
        
        self.player = player
        self.queuePlayback = queuePlayback
        self.preLoadCurrentTrack()
        self.startObservingProgress()
    }
    
    // MARK: Private methods
    private func preLoadCurrentTrack() {
        currentlyPlayingItem = queuePlayback.current
        
        if let url = queuePlayback.current?.url {
            player.replaceCurrentItem(with: AVPlayerItem(url: url))
        }
    }
    
    private func startObservingProgress() {
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) {  [weak self] time in
            self?.currentTimeSubject.send(time.seconds)
        }
    }
    
    private func play(track: DSMQueuePlaybackItem) {
        guard let url = track.url else { return }
        
        if currentlyPlayingItem?.url != url {
            currentlyPlayingItem = track
            player.replaceCurrentItem(with: AVPlayerItem(url: url))
        }
        player.play()
    }
    
    // MARK: Public methods
    func playCurrent() {
        guard let track = queuePlayback.playCurrent() else { return }
        play(track: track)
    }
    
    func playNext() {
        guard let track = queuePlayback.playNext() else { return }
        play(track: track)
    }
    
    func playPrevious() {
        guard let track = queuePlayback.playPreview() else { return }
        play(track: track)
    }
    
    func currentTime() -> Double {
        player.currentTime().seconds
    }
    
    func getDuration() -> Double {
        currentlyPlayingItem?.duration ?? .zero
    }
    
    func pause() {
        player.pause()
    }
    
    func stop() {
        player.pause()
        player.replaceCurrentItem(with: nil)
        currentlyPlayingItem = nil
    }
    
    func seek(to time: Double) {
        guard time >= 0,
              let duration = player.currentItem?.duration,
              duration.isNumeric,
              time <= duration.seconds else { return }
        
        player.seek(to: CMTime(seconds: time, preferredTimescale: 600), toleranceBefore: .zero, toleranceAfter: .zero) { [weak self] _ in
            guard let self else { return }
            self.currentTimeSubject.send(self.currentTime())
        }
    }
    
    deinit {
        if let observer = timeObserver {
            player.removeTimeObserver(observer)
        }
    }
}
