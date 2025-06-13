//
//  AppCoordinator.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import UIKit
import SwiftUI

@MainActor
final class AppCoordinator {
    let navigationController = UINavigationController()
    
    func start() -> UIViewController {
        let songCoordinator = SongCoordinator(navigationController: navigationController)
        let rootView = AppTabView(songCoordinator: songCoordinator)
        let hosting = UIHostingController(rootView: rootView)
        navigationController.setViewControllers([hosting], animated: false)
        return navigationController
    }
}
