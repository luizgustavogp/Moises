//
//  AppTabView.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

struct AppContainerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let appCoordinator = AppCoordinator()
        return appCoordinator.start()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
