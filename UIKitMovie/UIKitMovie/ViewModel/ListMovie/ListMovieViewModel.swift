// ListMovieViewModel.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Вью модель списка фильмов
final class ListMovieViewModel: ListMovieViewModelProtocol {
    // MARK: - Public Properties
    
    var errorAlert: ErrorHandler?
    var listMovieStates: ((ListMovieStates) -> ())?
    var networkService: NetworkServiceProtocol
    var imageService: ImageServiceProtocol
    var layoutHandler: VoidHandler?
    var listMovieProps: ListMovieStates = .initial {
        didSet {
            layoutHandler?()
        }
    }
    
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
        listMovieStates?(.initial)
        fetchMovies(method: .upcomingMethod)
    }
    
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
    
    // MARK: - Private Methods
    
    private func fetchMovies(method: MethodType) {
        networkService.fetchMovies(method: method) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.listMovieProps = .success(movies.movies)
            case let .failure(error):
                self.listMovieProps = .failure(error)
            }
        }
    }
}
