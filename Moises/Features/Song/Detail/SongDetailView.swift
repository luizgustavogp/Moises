//
//  SongDetailView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct SongDetailView: View {
    let song: Song

    @StateObject var viewModel: SongDetailViewModel

    var body: some View {
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
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showActionsSheet.toggle()
                } label: {
                    DSMImage(icon: .asset(name:"ellipsis.vertical"))
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $viewModel.showActionsSheet) {
            MoreActionsView(
                song: song,
                onOpenAlbum: {
                    viewModel.handleOpenAlbum()
                }
            )
            .presentationDetents([.fraction(0.25)])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $viewModel.showAlbumSheet) {
            AlbumsUIView(song: song, viewModel: AlbumViewModel())
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    }
}


#Preview {
    SongDetailView(song: Song.preview, viewModel: SongDetailViewModel())
}
