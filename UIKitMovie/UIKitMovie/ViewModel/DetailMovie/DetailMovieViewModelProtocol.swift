// DetailMovieViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью модели описания фильма
protocol DetailMovieViewModelProtocol {
    // MARK: - Public Properties

    var film: Movie? { get set }
    var imageService: ImageServiceProtocol { get set }

    // MARK: - Public Methods

    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
