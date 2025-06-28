import SwiftUI

struct AlbumsUIView: View {
    
    let song: SongModel
    
    @StateObject var viewModel: AlbumViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: DSMSize.Spacing.md) {
            DSMTitle(
                text: song.collectionName.orEmpty,
                alignment: .center,
                fontSize: .small,
                fontWeight: .bold
            )
            
            List(viewModel.songs) { song in
                SongRowView(
                    title: song.trackName.orEmpty,
                    subtitle: song.artistName,
                    imageUrl: song.artworkUrl100
                )
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .padding(.top, DSMSize.Spacing.lg)
        .padding(.horizontal, DSMSize.Spacing.md)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.customBackground.ignoresSafeArea())
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.loadSongs(for: song.collectionId)
        }
        .overlay {
            DSMLoadingView()
                .isHidden(viewModel.shouldShowLoadingView == false, remove: true)
        }
    }
}

#Preview {
    AlbumsUIView(song: SongModel.preview, viewModel: AlbumViewModel())
}
