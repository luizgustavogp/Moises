//
//  DSMAsyncImage.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//

import SwiftUI

struct DSMAsyncImage: View {
    let url: URL?
    var width: CGFloat = 44
    var height: CGFloat = 44
    var cornerRadius: CGFloat = DSMSize.CornerRadius.small
    var fallbackIcon: DSMIcon = .system(name: "music.note")

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                DSMImage(icon: fallbackIcon)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()

            case .failure:
                DSMImage(icon: fallbackIcon)
            @unknown default:
                DSMImage(icon: fallbackIcon)
            }
        }
        .frame(width: width, height: height)
        .clipped()
        .cornerRadius(cornerRadius)
    }
}


#Preview {
    DSMAsyncImage(url: URL(string: ""))
}
