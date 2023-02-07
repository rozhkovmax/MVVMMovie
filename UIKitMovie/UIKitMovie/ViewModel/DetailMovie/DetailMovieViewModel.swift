// DetailMovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель описания фильма
final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    // MARK: - Public Properties

    var film: Movie?
    var imageService: ImageServiceProtocol

    // MARK: - Initializers

    init(
        film: Movie?,
        imageService: ImageServiceProtocol
    ) {
        self.imageService = imageService
        self.film = film
    }

    // MARK: - Public Methods

    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        imageService.getImage(url: url) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
