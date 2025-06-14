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
        
    var body: some View {
        
        TabView {
            SongsUIView()
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
    AppTabView()
        .preferredColorScheme(.dark)
}

