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
                .accentColor(.customPrimary)
            
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
                    
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 36))
                        .padding()
                        .background(Circle().fill(Color.customPrimary))
                        .foregroundColor(Color.customBackground)
                }
                
                Button(action: {
                    viewModel.skipForward()
                    onSkipForward()
                }) {
                    DSMImage(icon: .system(name: "forward.fill"))
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
