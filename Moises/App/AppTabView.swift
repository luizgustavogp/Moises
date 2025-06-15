//
//  ContentView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 06/06/25.
//

import SwiftUI

struct AppTabView: View {
    @State private var selectedTab: Tab = .songs
    
    enum Tab: String, CaseIterable, LocalizableKey {
        case songs = "tab_songs"
        case profile = "tab_profile"
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SongsUIView(viewModel: SongsViewModel())
                .tabItem {
                    Label(Tab.songs.localized, systemImage: "music.note")
                }
                .tag(Tab.songs)
            
            ProfileUIView()
                .tabItem {
                    Label(Tab.profile.localized, systemImage: "person")
                }
                .tag(Tab.profile)
        }
        .tint(.tabBarActive)
        .foregroundColor(.customBackground)
    }
}

#Preview {
    AppTabView()
        .preferredColorScheme(.dark)
}

