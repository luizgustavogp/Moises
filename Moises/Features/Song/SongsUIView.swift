//
//  SongsUIView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct SongsUIView: View {
    
    @StateObject var viewModel: SongsViewModel
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            
            DSMErrorView(text: SongsStrings.errorGeneric.localized)
                .isHidden(viewModel.shouldShowErrorView == false, remove: true)
            
            DSMEmptyStateView(
                icon: .system(name: "music.note.list"),
                title: SongsStrings.emptyStateTitle.localized,
                subtitle: SongsStrings.emptyStateSubtitle.localized
            )
            .isHidden(viewModel.shouldShowEmptyState == false, remove: true)
            
            ScrollView {
                
                DSMLoadingView()
                    .isHidden(viewModel.shouldShowLoadingView == false, remove: true)
                
                LazyVStack(spacing: DSMSize.Spacing.md) {
                    ForEach(viewModel.songs) { song in
                        ListItemRowView(
                            title: song.trackName.orEmpty,
                            subtitle: song.artistName,
                            imageUrl: song.artworkUrl100
                        )
                        .onTapGesture {
                            path.append(song)
                        }
                        .onAppear {
                            viewModel.loadNextPageIfNeeded(currentSong: song)
                        }
                    }
                }
                .searchable(text: $viewModel.searchTerm, prompt: SongsStrings.searchPrompt.localized)
                .foregroundColor(Color.customPrimary)
                .refreshable {
                    viewModel.refresh()
                }
            }
            .padding(.horizontal, DSMSize.Spacing.md)
            .background(Color.customBackground)
            .navigationTitle(SongsStrings.title.localized)
            .navigationDestination(for: Song.self) { song in
                SongDetailView(song: song, viewModel: SongDetailViewModel())
            }
        }
    }
}

#Preview {
    SongsUIView(viewModel: SongsViewModel())
}
