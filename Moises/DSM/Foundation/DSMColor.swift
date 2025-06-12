//
//  DS.swift
//  Moises
//
//  Created by Gustavo Guimarães on 06/06/25.
//

import SwiftUI

extension Color {
    
    /// Primary background color for the app.
    /// Use as the base layer behind all content.
    static let dsmBackground = Color("CustomBackground")
    
    /// Surface color used for components on top of the background.
    /// Use for cards, buttons, modals, and containers.
    static let dsmSurface = Color("Surface")
    
    /// Main brand/action color.
    /// Use for primary buttons, active icons, and accent elements.
    static let dsmPrimary = Color("CustomPrimary")
    
    /// Foreground color to be used on top of `dsmPrimary`.
    /// Use for text or icons placed over primary-colored elements.
    static let dsmOnPrimary = Color("OnPrimary")
    
    /// Foreground color to be used on top of `dsmSurface`.
    /// Use for primary text and icons inside containers.
    static let dsmOnSurface = Color("OnSurface")
    
    /// Secondary text color for subtitles and less prominent labels.
    /// Use for descriptions, muted icons, and supplementary information.
    static let dsmSecondaryText = Color("SecondaryText")
    
    /// Color for the active tab item in the TabBar.
    /// Use for the selected tab’s icon and label.
    static let dsmTabBarActive = Color("TabBarActive")
    
    /// Accent color used for status, branding, highlights
    static let dsmHighlight = Color("Highlight")
}

