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
        AppNavBar(leadingButton: .none,
                  content:  {
            VStack(alignment: .leading, spacing: DSMSize.Spacing.md) {
                
                SearchTextField(text: $viewModel.searchTerm, placeholder: "Search")
                    .padding(.horizontal, DSMSize.Spacing.md)
                
                ScrollView {
                    LazyVStack(spacing: DSMSize.Spacing.md) {
                        ForEach(viewModel.songs) { song in
                            SongRowView(song: song)
                                .onTapGesture {
                                    coordinator?.goToDetail(song: song)
                                }
                                .onAppear {
                                    if song.trackId == viewModel.songs.last?.trackId {
                                        viewModel.loadNextPageIfNeeded()
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, DSMSize.Spacing.md)
                    .padding(.top, DSMSize.Spacing.sm)
                    
                    if viewModel.state == .loading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(maxWidth: .infinity)
                    }
                    
                    if case .error(let message) = viewModel.state {
                        Text(message)
                            .foregroundColor(.pink)
                            .padding(.top, DSMSize.Spacing.sm)
                    }
                }
                .refreshable {
                    viewModel.refresh()
                }
            }
            .customNavigationTitle("Songs")
            .padding(.top, DSMSize.Spacing.lg)
            .padding(.horizontal, DSMSize.Spacing.sm)
            .background(Color.dsmBackground)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
    }
}


#Preview {
    SongsUIView(coordinator: nil)
}
