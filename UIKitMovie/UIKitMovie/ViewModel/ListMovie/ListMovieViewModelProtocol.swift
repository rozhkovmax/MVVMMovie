// ListMovieViewModelProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Протокол вью модели списка фильмов
protocol ListMovieViewModelProtocol {
    // MARK: - Public Properties

    var errorAlert: ErrorHandler? { get set }
    var networkService: NetworkServiceProtocol { get set }
    var imageService: ImageServiceProtocol { get set }
    var listMovieStates: ((ListMovieStates) -> ())? { get set }
    var listMovieProps: ListMovieStates { get set }
    var layoutHandler: VoidHandler? { get set }

    // MARK: - Public Methods

    func fetchMovies()
    func segmentControlAction(index: Int)
    func fetchImage(url: String, handler: @escaping DataHandler)
}
