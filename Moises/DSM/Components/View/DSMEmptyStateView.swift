//
//  DSMEmptyStateView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import SwiftUI

struct DSMEmptyStateView: View {
    let icon: DSMIcon
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: DSMSize.Spacing.md) {
            DSMImage(icon: icon, size: DSMSize.Icon.xlarge)
                .padding(.top, DSMSize.Spacing.lg)
            
            DSMTitle(text: title, alignment: .center, fontSize: .large, fontWeight: .bold)
                .multilineTextAlignment(.center)
            
            DSMSubtitle(text: subtitle, alignment: .center)
                .multilineTextAlignment(.center)
            
        }
        .padding(.horizontal, DSMSize.Spacing.lg)
    }
}

#Preview {
    DSMEmptyStateView(icon: .system(name: "music.note.list"), title: "Empty", subtitle: "Empty")
}
