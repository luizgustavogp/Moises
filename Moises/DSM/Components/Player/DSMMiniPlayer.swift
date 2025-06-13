//
//  DSMMiniPlayer.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//

import SwiftUI

struct DSMMiniPlayer: View {
    @ObservedObject var viewModel: MiniPlayerViewModel
    
    var onPlayPauseTapped: () -> Void
    var onSkipForward: () -> Void
    var onSkipBackward: () -> Void
    
    var body: some View {
        VStack(spacing: DSMSize.Spacing.xs) {
            
            Slider(value: $viewModel.progress, in: 0...1)
                .accentColor(.dsmPrimary)
            
            HStack {
                DSMTitle(text: viewModel.currentTime, fontSize: .small)
                Spacer()
                DSMTitle(text: viewModel.remainingTime, alignment: .trailing, fontSize: .small)
            }
            
            HStack(spacing: DSMSize.Spacing.xl) {
                Button(action: {
                    viewModel.skipBackward()
                    onSkipBackward()
                }) {
                    DSMImage(icon: .system(name: "backward.fill"))
                }
                
                Button(action: {
                    viewModel.togglePlayPause()
                    onPlayPauseTapped()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.dsmPrimary)
                            .frame(width: 60, height: 60)
                        
                        DSMImage(icon: .system(name: viewModel.isPlaying ? "pause.fill" : "play.fill"),
                                 color: .customBackground)
                    }
                }
                
                Button(action: {
                    viewModel.skipForward()
                    onSkipForward()
                }) {
                    DSMImage(icon: .system(name:  "forward.fill"))
                }
            }
            .padding(.top, DSMSize.Spacing.sm)
        }
        .cornerRadius(DSMSize.CornerRadius.medium)
    }
}

#Preview {
    DSMMiniPlayer(
        viewModel: MiniPlayerViewModel(trackTimeMillis: 210000),
        onPlayPauseTapped: {
            print("Play/Pause")
        },
        onSkipForward: {
            print("Next")
        },
        onSkipBackward: {
            print("Back")
        }
    )
}
