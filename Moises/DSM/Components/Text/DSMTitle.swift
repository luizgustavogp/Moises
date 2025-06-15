//
//  DSMTitle.swift
//  Moises
//
//  Created by Gustavo Guimarães on 07/06/25.
//

import SwiftUI

struct DSMTitle: View {
    let text: String
    var alignment: Alignment = .leading
    var fontSize = DSMFontSize.xxLarge
    var fontWeight = DSMFontWeight.bold

    var body: some View {
        Text(text)
            .font(DSMFont.sfProDisplay(size: fontSize, weight: fontWeight))
            .foregroundColor(.onSurface)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}
#Preview {
    DSMTitle(text: "Hello World")
}
