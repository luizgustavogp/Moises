//
//  DSMMiniPlayerViewModel.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//

import Combine
import Foundation

final class MiniPlayerViewModel: ObservableObject {
    
    @Published var progress: Double = 0.0
    @Published var isPlaying: Bool = false

    let trackTimeMillis: Int

    private var timer: AnyCancellable?

    var currentTime: String {
        Int(trackTimeMillis.asDouble * progress).asTimeString
    }

    var remainingTime: String {
        "-" + (trackTimeMillis - Int(trackTimeMillis.asDouble * progress)).asTimeString
    }

    init(trackTimeMillis: Int) {
        self.trackTimeMillis = trackTimeMillis
    }

    func togglePlayPause() {
        isPlaying.toggle()

        if isPlaying {
            startTimer()
        } else {
            stopTimer()
        }
    }

    func skipForward() {
        progress = min(progress + 0.05, 1.0)
    }

    func skipBackward() {
        progress = max(progress - 0.05, 0.0)
    }

    private func startTimer() {
        timer = Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                let step = 1.0 / (self.trackTimeMillis.asDouble / 1000.0)
                self.progress = min(self.progress + step, 1.0)

                if self.progress >= 1.0 {
                    self.stopTimer()
                    self.isPlaying = false
                }
            }
    }

    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    deinit {
        stopTimer()
    }
}
