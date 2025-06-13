//
//  SongCoordinator.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import UIKit
import SwiftUI


final class SongCoordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    @MainActor
    func goToDetail(song: Song) {
        let detailView = SongDetailView(song: song)
        let hosting = UIHostingController(rootView: detailView)
        navigationController.pushViewController(hosting, animated: true)
    }
}
