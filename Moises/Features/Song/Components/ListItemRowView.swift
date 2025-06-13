//
//  ListItemRowView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import SwiftUI

struct ListItemRowView: View {
    let title: String
    let subtitle: String
    let imageUrl: String
    
    var body: some View {
        HStack(spacing: DSMSize.Spacing.md) {
            DSMAsyncImage(url: URL(string: imageUrl))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(DSMFont.listTitle)
                    .foregroundColor(.dsmPrimary)
                
                Text(subtitle)
                    .font(DSMFont.listSubtitle)
                    .foregroundColor(.dsmSecondaryText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, DSMSize.Spacing.sm)
    }
}
