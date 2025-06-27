//
//  DSMIcon.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

enum DSMIcon {
    case system(name: String)
    case asset(name: String)
}

struct DSMImage: View {
    let icon: DSMIcon
    var size: CGFloat = DSMSize.Icon.medium
    var color: Color = .customPrimary
    
    var body: some View {
        iconView
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundColor(color)
    }
    
    @ViewBuilder
    private var iconView: some View {
        switch icon {
        case .system(let name):
            Image(systemName: name)
                .resizable()
        case .asset(let name):
            Image(name)
                .resizable()
        }
    }
}
#Preview {
    DSMImage(icon: .system(name: "person.circle"))
}

#Preview {
    DSMImage(icon: .asset(name: "ic-playlist"), size: DSMSize.Icon.small)
}
