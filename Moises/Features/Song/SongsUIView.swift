//
//  SongsUIView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct SongsUIView: View {
    
    @StateObject private var viewModel = SongsViewModel()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack (path: $path) {
            
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
                            path.append(song)
                        }
                        .onAppear {
                            viewModel.loadNextPageIfNeeded(currentSong: song)
                        }
                    }
                }
                .searchable(text: $viewModel.searchTerm, prompt: "Search")
                .foregroundColor(Color.dsmPrimary)
                .refreshable {
                    viewModel.refresh()
                }
            }
            .padding(.horizontal, DSMSize.Spacing.md)
            .background(Color.dsmBackground)
            .navigationTitle("Songs")
            .navigationDestination(for: Song.self) { song in
                SongDetailView(song: song)
            }
        }
    }
}


#Preview {
    SongsUIView()
}
