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
                DSMTitle(text: title, fontSize: .medium)
                
                DSMSubtitle(text: subtitle)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, DSMSize.Spacing.sm)
    }
}
