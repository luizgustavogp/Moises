//
//  DSMIconButton.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//

import SwiftUI

struct DSMIconButton: View {
    let icon: DSMIcon
    let title: String
    let action: Action
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: DSMSize.Spacing.sm) {
                DSMImage(icon: icon)
                DSMTitle(text: title, fontSize: .medium, fontWeight: .regular)
            }
            .frame(maxWidth: .infinity)
            .background(Color.clear)
        }
    }
}
#Preview {
    DSMIconButton(icon: .system(name: "gear"), title: "Click me", action: {})
}
