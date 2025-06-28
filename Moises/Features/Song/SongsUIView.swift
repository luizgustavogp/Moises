//
//  SongsUIView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct SongsUIView: View {
    
    @StateObject var viewModel: SongsViewModel<RunLoop>
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(viewModel.songs) { song in
                SongRowView(
                    title: song.trackName.orEmpty,
                    subtitle: song.artistName,
                    imageUrl: song.artworkUrl100
                )
                .onTapGesture {
                    path.append(song)
                }
                .onAppear {
                    Task {
                        await viewModel.loadNextPageIfNeeded(currentSong: song)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .background(.customBackground)
            .navigationTitle(SongsStrings.title.localized)
            .navigationDestination(for: SongModel.self) { song in
                SongDetailView(
                    song: song,
                    viewModel: SongDetailViewModel(),
                    miniPlayerviewModel: DSMMiniPlayerFactory.makeViewModel(for: song)
                )
            }
            .refreshable {
                await viewModel.refresh()
            }
            .searchable(text: $viewModel.searchTerm, prompt: SongsStrings.searchPrompt.localized)
            .foregroundColor(.customPrimary)
            .overlay {
                DSMErrorView(text: SongsStrings.errorGeneric.localized)
                    .isHidden(viewModel.shouldShowErrorView == false, remove: true)
                
                DSMEmptyStateView(
                    icon: .system(name: "music.note.list"),
                    title: SongsStrings.emptyStateTitle.localized,
                    subtitle: SongsStrings.emptyStateSubtitle.localized
                )
                .isHidden(viewModel.shouldShowEmptyState == false, remove: true)
                
                DSMLoadingView()
                    .isHidden(viewModel.shouldShowLoadingView == false, remove: true)
                
            }
        }
    }
}

#Preview {
    SongsUIView(viewModel: SongsViewModel())
}
