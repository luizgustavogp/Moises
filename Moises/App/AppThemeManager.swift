//
//  AppThemeManager.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import SwiftUI

class AppThemeManager: ObservableObject {
    @AppStorage("selectedTheme") var selectedThemeRaw: String = DSMThemeMode.dark.rawValue

    var selectedTheme: DSMThemeMode {
        DSMThemeMode(rawValue: selectedThemeRaw) ?? .dark
    }

    var colorScheme: ColorScheme {
        selectedTheme.colorScheme
    }
}
