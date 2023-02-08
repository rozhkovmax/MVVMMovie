// ApplicationCoordinator.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Координатор запуска приложения
final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var assemblyBuilder: AssemblyBuilderProtocol?

    // MARK: - Initializers

    init(assemblyBuilder: AssemblyBuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Public Methods

    override func start() {
        guard let assemblyBuilder = assemblyBuilder else { return }
        showListMovieModule(assemblyBuilder: assemblyBuilder)
    }

    // MARK: - Private Methods

    private func showListMovieModule(assemblyBuilder: AssemblyBuilderProtocol) {
        let coordinator = ListMovieCoordinator(assemblyBuilder: assemblyBuilder)
        addDependency(coordinator)
        coordinator.start()
    }
}
