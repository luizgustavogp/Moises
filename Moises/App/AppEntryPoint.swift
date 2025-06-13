//
//  MoisesApp.swift
//  Moises
//
//  Created by Gustavo Guimarães on 06/06/25.
//

import SwiftUI

@main
struct AppEntryPoint: App {
    
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            AppContainerView()
                .preferredColorScheme(themeManager.colorScheme)
                .environmentObject(themeManager)
                .ignoresSafeArea()
        }
    }
}
