//
//  DSMMiniPlayerControl.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//

import SwiftUI

struct DSMMiniPlayerControl: View {
    @ObservedObject var viewModel: DSMMiniPlayerControlViewModel
    
    var onPlayPauseTapped: () -> Void
    var onSkipForward: () -> Void
    var onSkipBackward: () -> Void
    
    var body: some View {
        VStack(spacing: DSMSize.Spacing.xs) {
            
            Slider(value: $viewModel.progress, in: 0...1, onEditingChanged: { editing in
                viewModel.isSeeking = editing
            })
            .onChange(of: viewModel.progress) { _ in
                if viewModel.isSeeking {
                    viewModel.seek()
                }
            }
            .accentColor(.customPrimary)
            
            HStack {
                DSMTitle(text: viewModel.currentTime, fontSize: .small)
                Spacer()
                DSMTitle(text: viewModel.totalTime, alignment: .trailing, fontSize: .small)
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
        .onDisappear {
            viewModel.stop()
        }
    }
}

#Preview {
    DSMMiniPlayerControl(
        viewModel: DSMMiniPlayerControlViewModel(playerService: DSMMiniAvPlayerService()),
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
