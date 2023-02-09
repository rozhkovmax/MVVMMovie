// DetailMovieViewModel.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Вью модель описания фильма
final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    // MARK: - Public Properties

    var film: MovieData?
    var imageService: ImageServiceProtocol
    var errorAlert: ErrorHandler?

    // MARK: - Initializers

    init(
        film: MovieData?,
        imageService: ImageServiceProtocol
    ) {
        self.imageService = imageService
        self.film = film
    }

    // MARK: - Public Methods

    func fetchImage(url: String, handler: @escaping DataHandler) {
        imageService.getImage(url: url) { [weak self] result in
            switch result {
            case let .success(data):
                handler(data)
            case let .failure(error):
                self?.errorAlert?(error)
            }
        }
    }
}
