//
//  DSMThemeMode.swift
//  Moises
//
//  Created by Gustavo Guimarães on 13/06/25.
//

import SwiftUI

enum DSMThemeMode: String, CaseIterable, Identifiable {
    case light, dark
    
    var id: String { rawValue }
    
    var description: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
    
    var colorScheme: ColorScheme {
        switch self {
        case .light: return .light
        case .dark: return .dark
        }
    }
}
