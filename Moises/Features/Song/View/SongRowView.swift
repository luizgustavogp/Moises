//
//  SongRowView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct SongRowView: View {
    let song: Song
    
    var body: some View {
        HStack(spacing: DSMSize.Spacing.md) {
            
            DSMAsyncImage(url: URL(string: song.artworkUrl100))
            
            VStack(alignment: .leading) {
                Text(song.trackName)
                    .font(DSMFont.listTitle)
                    .foregroundColor(.dsmPrimary)
                
                Text(song.artistName)
                    .font(DSMFont.listSubtitle)
                    .foregroundColor(.dsmSecondaryText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, DSMSize.Spacing.sm)
    }
}
