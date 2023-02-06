// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let movieVC = MovieViewController()
        let navigationController = UINavigationController(rootViewController: movieVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.backgroundColor = .white
        self.window = window
    }
}
