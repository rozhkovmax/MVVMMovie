// ListMovieViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью модели списка фильмов
protocol ListMovieViewModelProtocol {
    // MARK: - Public Properties

    var updateView: (() -> ())? { get set }
    var errorAlert: ((Error) -> ())? { get set }
    var movies: [Movie] { get set }
    var networkService: NetworkServiceProtocol { get set }
    var imageService: ImageServiceProtocol { get set }
    var listMovieStates: ((ListMovieStates) -> ())? { get set }

    // MARK: - Public Methods

    func fetchMovies()
    func segmentControlAction(index: Int)
    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
