//
//  DSMSubtitle.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//

import SwiftUI

struct DSMSubtitle: View {
    let text: String
    var alignment: Alignment = .leading
    var fontSize = DSMFontSize.small
    var fontWeight = DSMFontWeight.regular

    var body: some View {
        Text(text)
            .font(DSMFont.sfProDisplay(size: fontSize, weight: fontWeight))
            .foregroundColor(.dsmSecondaryText)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}
#Preview {
    DSMSubtitle(text: "Hello World")
}
