//
//  MiniPlayerControlViewModel.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//

import Combine
import Foundation

final class DSMMiniPlayerControlViewModel: ObservableObject {
    
    @Published var progress: Double = 0.0
    @Published var isSeeking: Bool = false
    @Published var isPlaying: Bool = false
    @Published var currentTime: String = ""
    @Published var totalTime: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private var playerService: DSMMiniPlayerService
    
    init(playerService: DSMMiniPlayerService) {
        self.playerService = playerService
        
        updateTime()
        observeCurrentTime()
    }
    
    //MARK: Private methods
    private func observeCurrentTime() {
        playerService.currentTimePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] current in
                guard let self else { return }
                
                let duration = self.playerService.getDuration()
                if !self.isSeeking {
                    self.progress = duration > 0 ? current / duration : 0
                }
                self.updateTime()
            }
            .store(in: &cancellables)
    }
    
    private func updateTime() {
        currentTime = Int(playerService.currentTime()).asTimeString
        totalTime = Int(playerService.getDuration()).asTimeString
    }
    
    // MARK: Public methods
    func togglePlayPause() {
        isPlaying.toggle()
        if isPlaying {
            playerService.playCurrent()
        } else {
            playerService.pause()
        }
    }
    
    func skipForward() {
        let duration = playerService.getDuration()
        let current = playerService.currentTime()
        let skip = duration * 0.05
        let newTime = min(current + skip, duration)
        
        playerService.seek(to: newTime)
    }
    
    func skipBackward() {
        let duration = playerService.getDuration()
        let current = playerService.currentTime()
        let skip = duration * 0.05
        let newTime = max(current - skip, 0)
        
        playerService.seek(to: newTime)
    }
    
    func seek() {
        let duration = playerService.getDuration()
        let newTime = duration * progress
        
        playerService.seek(to: newTime)
    }
    
    func stop() {
        isPlaying = false
        progress = 0.0
        playerService.stop()
    }
}
