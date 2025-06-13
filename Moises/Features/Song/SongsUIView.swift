//
//  SongsUIView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct SongsUIView: View {
    
    var coordinator: SongCoordinator?
    
    @StateObject private var viewModel = SongsViewModel()
    
    var body: some View {
        AppNavBar(leadingButton: .none) {
            VStack(alignment: .leading, spacing: DSMSize.Spacing.md) {
                
                SearchTextField(text: $viewModel.searchTerm, placeholder: "Search")
                                
                DSMErrorView(text: "Something went wrong")
                    .isHidden(viewModel.shouldShowErrorView == false, remove: true)

                DSMEmptyStateView(
                    icon: .system(name: "music.note.list"),
                    title: "It looks empty around here",
                    subtitle: "Try changing your search"
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
                                coordinator?.goToDetail(song: song)
                            }
                            .onAppear {
                                viewModel.loadNextPageIfNeeded(currentSong: song)
                            }
                        }
                    }
                }
                .refreshable {
                    viewModel.refresh()
                }
            }
            .customNavigationTitle("Songs")
            .padding([.top, .horizontal], DSMSize.Spacing.md)
            .background(Color.dsmBackground)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


#Preview {
    SongsUIView(coordinator: nil)
}
