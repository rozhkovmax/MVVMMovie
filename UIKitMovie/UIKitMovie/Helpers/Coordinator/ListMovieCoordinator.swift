// ListMovieCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор списка фильмов
final class ListMovieCoordinator: BaseCoordinator {
    // MARK: - Private Visual Components

    private var rootController: UINavigationController?

    // MARK: - Public Properties

    var onDetailMovieModule: ((Movie) -> ())?
    var assemblyBuilder: AssemblyBuilderProtocol?

    // MARK: - Initializers

    init(assemblyBuilder: AssemblyBuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Public Methods

    override func start() {
        showListMovieModule()
    }

    // MARK: - Private Methods

    private func showListMovieModule() {
        guard let controller = assemblyBuilder?.makeListMovieModule() as? ListMovieViewController else { return }
        controller.onDetailMovieModule = { [weak self] movie in
            self?.showDetailMovieModule(movie: movie)
        }
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }

    private func showDetailMovieModule(movie: Movie) {
        guard let controller = assemblyBuilder?
            .makeDetailMovieModule(movie: movie) as? DetailMovieViewController else { return }
        rootController?.pushViewController(controller, animated: true)
    }
}
