//
//  DSMLoadingView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import SwiftUI

struct DSMLoadingView: View {
    var body: some View {
        ZStack {
            Color.clear
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .customPrimary))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    DSMLoadingView()
}
