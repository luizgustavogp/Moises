//
//  DSMLoadingView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import SwiftUI

struct DSMLoadingView: View {
    var body: some View {
        ProgressView()
            .background(Color.clear)
            .progressViewStyle(CircularProgressViewStyle(tint: .customPrimary))        
    }
}

#Preview {
    DSMLoadingView()
}
