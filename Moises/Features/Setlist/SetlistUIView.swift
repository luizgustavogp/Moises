//
//  SetlistUIView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct SetlistUIView: View {
    var body: some View {
        AppNavBar(
            leadingButton: .back,
            trailingButton: .none,
            content: {
                Color.dsmBackground
                    .customNavigationTitle("Setlist")
            }
        )
    }
}

#Preview {
    SetlistUIView()
}
