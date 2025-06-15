//
//  MoreActionsView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//

import SwiftUI

struct MoreActionsView: View {
    
    let song: Song    
    let onOpenAlbum: () -> Void

    var body: some View {
        VStack(spacing: DSMSize.Spacing.lg) {
            VStack(spacing: DSMSize.Spacing.sm) {
               
                DSMTitle(text: song.trackName.orEmpty, alignment: .center, fontSize: .large, fontWeight: .semibold)
                
                DSMSubtitle(text: song.artistName, alignment: .center)                
            }
            .multilineTextAlignment(.center)

            DSMIconButton(
                icon: .asset(name: "playlist"),
                title: MoreActionsStrings.openAlbum.localized,
                action: onOpenAlbum
            )
            .padding(.top, DSMSize.Spacing.xl)
        }
        .padding(DSMSize.Spacing.lg)
    }
}


#Preview {
    MoreActionsView(song: Song.preview, onOpenAlbum: {})
}
