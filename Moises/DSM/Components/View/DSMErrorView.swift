//
//  DSMErrorView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import SwiftUI

struct DSMErrorView: View {
    let text: String
    
    var body: some View {
        VStack(spacing: DSMSize.Spacing.md) {
            DSMImage(icon: .system(name: "figure.fall"), size: DSMSize.Icon.xlarge)
                .padding(.top, DSMSize.Spacing.lg)
            
            DSMTitle(text: text, alignment: .center, fontSize: .large, fontWeight: .bold)
                .multilineTextAlignment(.center)
            
        }
        .padding(.horizontal, DSMSize.Spacing.lg)
    }
}

#Preview {
    DSMErrorView(text: "Ops... Something went wrong!")
}
