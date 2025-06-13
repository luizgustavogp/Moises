//
//  ProfileUIView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct ProfileUIView: View {
    
    @EnvironmentObject var themeManager: AppThemeManager

    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Picker("Theme", selection: $themeManager.selectedThemeRaw) {
                    ForEach(DSMThemeMode.allCases) { mode in
                        Text(mode.description).tag(mode.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationTitle("Profile")
    }
}

