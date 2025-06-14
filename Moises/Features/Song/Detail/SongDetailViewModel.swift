//
//  SongDetailViewModel.swift
//  Moises
//
//  Created by Gustavo Guimarães on 14/06/25.
//

import Foundation
import SwiftUI

final class SongDetailViewModel: ObservableObject {
    
    @Published var showActionsSheet = false
    @Published var showAlbumSheet = false

    func handleOpenAlbum() {
        showActionsSheet = false
        showAlbumSheet = true
    }
}
