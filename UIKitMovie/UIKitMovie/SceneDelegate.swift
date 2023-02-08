// SceneDelegate.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// SceneDelegate
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public Properties

    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?

    // MARK: - Public Methods

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        let assemblyBuilder = AssemblyBuilder()
        applicationCoordinator = ApplicationCoordinator(assemblyBuilder: assemblyBuilder)
        applicationCoordinator?.start()
    }
}
