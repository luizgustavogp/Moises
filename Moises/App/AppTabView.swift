//
//  ContentView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 06/06/25.
//

import SwiftUI

struct AppTabView: View {
    @State private var selectedTab: Tab = .songs
    
    enum Tab {
        case songs, profile
    }
    
    let songCoordinator: SongCoordinator?
    
    var body: some View {
        TabView {
            SongsUIView(coordinator: songCoordinator)
                .tabItem {
                    Label("Songs", systemImage: "music.note")
                }.tag(Tab.songs)
            
            
            ProfileUIView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }.tag(Tab.profile)
        }
        .tint(.dsmTabBarActive)
        .foregroundColor(.dsmBackground)
    }
}

#Preview {
    AppTabView(songCoordinator: nil)
        .preferredColorScheme(.dark)
}

