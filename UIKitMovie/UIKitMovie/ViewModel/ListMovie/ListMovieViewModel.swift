// ListMovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель списка фильмов
final class ListMovieViewModel: ListMovieViewModelProtocol {
    // MARK: - Public Properties

    var movies: [Movie] = []
    var updateView: (() -> ())?
    var errorAlert: ((Error) -> ())?
    var listMovieStates: ((ListMovieStates) -> ())?
    var networkService: NetworkServiceProtocol
    var imageService: ImageServiceProtocol

    // MARK: - Initializers

    init(
        networkService: NetworkServiceProtocol,
        imageService: ImageServiceProtocol
    ) {
        self.networkService = networkService
        self.imageService = imageService
    }

    // MARK: - Public Methods

    func segmentControlAction(index: Int) {
        switch index {
        case 0:
            fetchMovies(method: .upcomingMethod)
        case 1:
            fetchMovies(method: .popularMethod)
        case 2:
            fetchMovies(method: .topRatedMethod)
        default:
            break
        }
    }

    func fetchMovies() {
        fetchMovies(method: .upcomingMethod)
    }

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

    // MARK: - Private Methods

    private func fetchMovies(method: MethodType) {
        networkService.fetchMovies(method: method) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.movies = movies.movies
                self.listMovieStates?(.success)
            case let .failure(error):
                self.listMovieStates?(.failure(error))
            }
        }
    }
}
