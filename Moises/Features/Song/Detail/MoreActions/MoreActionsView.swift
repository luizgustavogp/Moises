//
//  MoreActionsView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//

import SwiftUI

struct MoreActionsView: View {
    
    let song: Song    
    var onOpenAlbum: () -> Void

    var body: some View {
        VStack(spacing: DSMSize.Spacing.lg) {
            VStack(spacing: DSMSize.Spacing.sm) {
               
                DSMTitle(text: song.trackName, alignment: .center, fontSize: .large, fontWeight: .semibold)
                
                DSMSubtitle(text: song.artistName, alignment: .center)
                
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .top)

            Spacer()

            DSMIconButton(
                icon: .asset(name: "ic-playlist"),
                title: "Open album",
                action: onOpenAlbum
            )
            .padding(.bottom, DSMSize.Spacing.xl)
        }
        .padding(DSMSize.Spacing.lg)
    }
}


#Preview {
    MoreActionsView(song: Song.preview, onOpenAlbum: {})
}
