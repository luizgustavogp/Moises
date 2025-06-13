//
//  AlbumsUIView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import SwiftUI

struct AlbumsUIView: View {
    
    let song: Song
    
    @StateObject private var viewModel = AlbumViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: DSMSize.Spacing.md) {
            DSMTitle(text: song.collectionName.orEmpty,
                     alignment: .center,
                     fontSize: .small,
                     fontWeight: .bold)
                        
            ScrollView {
                LazyVStack(spacing: DSMSize.Spacing.md) {
                    ForEach(viewModel.songs) { song in
                        ListItemRowView(
                            title: song.trackName.orEmpty,
                            subtitle: song.artistName,
                            imageUrl: song.artworkUrl100
                        )
                    }
                }
            }
        }
        .padding(.top, DSMSize.Spacing.lg)
        .padding(.horizontal, DSMSize.Spacing.md)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.dsmBackground.ignoresSafeArea())
        .onAppear {
            viewModel.loadSongs(for: song.collectionId)
        }
    }
}

#Preview {
    AlbumsUIView(song: Song.preview)
}
