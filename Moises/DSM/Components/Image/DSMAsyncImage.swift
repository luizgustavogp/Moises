//
//  DSMAsyncImage.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//

import SwiftUI
import Kingfisher

struct DSMAsyncImage: View {
    let url: URL?
    var width: CGFloat = 44
    var height: CGFloat = 44
    var cornerRadius: CGFloat = DSMSize.CornerRadius.small
    var fallbackIcon: DSMIcon = .system(name: "music.note")

    @State private var didFail = false

    var body: some View {
        ZStack {
            if let url, !didFail {
                KFImage(url)
                    .onFailure { _ in didFail = true }
                    .resizable()
                    .scaledToFill()
            } else {
                DSMImage(icon: fallbackIcon)
                    .frame(width: width, height: height)
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
