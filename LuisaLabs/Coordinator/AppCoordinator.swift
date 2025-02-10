//
//  AppCoordinator.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 04/02/25.
//

import Components
import SwiftUI
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    lazy var navigationController: UINavigationController = {
        let navController = UINavigationController()
        return navController
    }()

    func start() {
        let controller = UIHostingController(rootView: GitHubRepositoriesView())
        navigationController.viewControllers = [controller]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
