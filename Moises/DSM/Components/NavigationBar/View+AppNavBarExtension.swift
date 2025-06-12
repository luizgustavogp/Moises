//
//  View+AppNavBarExtension.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

extension View {
    func customNavigationTitle(_ title: String) -> some View {
        self.preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
    }
}
