//
//  SearchTextField.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var text: String
    
    var placeholder: String = "Search"

    var body: some View {
        HStack(spacing: DSMSize.Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.dsmPrimary)

            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(DSMFont.sfProDisplay(size: .medium, weight: .regular))
                .foregroundColor(.dsmSecondaryText)
        }
        .padding(DSMSize.Spacing.md)
        .background(Color.dsmSurface)
        .cornerRadius(DSMSize.CornerRadius.medium)
    }
}

#Preview {
    SearchTextField(text: .constant("Search"))
}
