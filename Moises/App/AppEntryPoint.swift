//
//  MoisesApp.swift
//  Moises
//
//  Created by Gustavo Guimarães on 06/06/25.
//

import SwiftUI

@main
struct AppEntryPoint: App {
    
    @StateObject private var themeManager = AppThemeManager()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .preferredColorScheme(themeManager.colorScheme)
                .environmentObject(themeManager)
                .ignoresSafeArea()
        }
    }
}
