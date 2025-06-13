//
//  SongDetailView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct SongDetailView: View {
    let song: Song
    
    @State private var progress: Double = 0.0
    @State private var showBottonSheet = false
    @State private var showAlbumSheet = false
    
    var body: some View {
        AppNavBar(leadingButton: .back,
                  trailingButton: .custom(
                    view: AnyView(
                        Button(action: {
                            showBottonSheet.toggle()
                        }) {
                            DSMImage(icon: .system(name: "ellipsis"))
                        }
                    )
                  ),
                  content:  {
            VStack(spacing: DSMSize.Spacing.md) {
                
                Spacer()
                
                DSMAsyncImage(url: song.artworkUrl100.toURL(), width: 200, height: 200)
                
                Spacer()
                
                VStack(spacing: DSMSize.Spacing.lg) {
                    
                    VStack(spacing: DSMSize.Spacing.xs) {
                        
                        DSMTitle(text: song.trackName.orEmpty, fontSize: .large, fontWeight: .semibold)
                        
                        DSMSubtitle(text: song.artistName)
                    }
                    
                    DSMMiniPlayer(
                        viewModel: MiniPlayerViewModel(trackTimeMillis: song.trackTimeMillis.orZero),
                        onPlayPauseTapped: {},
                        onSkipForward: {},
                        onSkipBackward: {}
                    )
                }
            }
            .customNavigationTitle("Song Details")
            .padding()
            .sheet(isPresented: $showBottonSheet) {
                MoreActionsView(song: song, onOpenAlbum: {
                    showBottonSheet.toggle()
                    showAlbumSheet.toggle()
                })
                .presentationDetents([.fraction(0.3), .fraction(0.4)])
            }
            .sheet(isPresented: $showAlbumSheet) {
                AlbumsUIView(song: song)
                    .presentationDetents([.fraction(1), .large])
            }
        })
    }
}

#Preview {
    SongDetailView(song: Song.preview)
}
