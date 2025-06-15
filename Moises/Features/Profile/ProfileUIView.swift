//
//  ProfileUIView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct ProfileUIView: View {

    @EnvironmentObject var themeManager: AppThemeManager
    @AppStorage("appLanguage") private var selectedLanguage = Locale.current.language.languageCode?.identifier ?? "en"

    var body: some View {
        Form {
            Section(header: DSMTitle(text: ProfileStrings.appearance.localized)) {
                Picker(ProfileStrings.theme.localized, selection: $themeManager.selectedThemeRaw) {
                    ForEach(DSMThemeMode.allCases) { mode in
                        Text(mode.description).tag(mode.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationTitle(ProfileStrings.title.localized)
    }
}
