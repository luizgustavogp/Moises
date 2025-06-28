//
//  SongRowView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import SwiftUI

struct SongRowView: View {
    let title: String
    let subtitle: String
    let imageUrl: String
    
    var body: some View {
        HStack(spacing: DSMSize.Spacing.md) {
            DSMAsyncImage(url: imageUrl.toURL())
            
            VStack(alignment: .leading, spacing: DSMSize.Spacing.xs) {
                DSMTitle(text: title, fontSize: .medium)
                
                DSMSubtitle(text: subtitle)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, DSMSize.Spacing.sm)
    }
}
