// ListMovieViewModel.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Вью модель списка фильмов
final class ListMovieViewModel: ListMovieViewModelProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let coreDataModelName = "MovieDataModel"
    }

    // MARK: - Public Properties

    var coreDataStack = CoreDataStack(modelName: Constants.coreDataModelName)
    var errorAlert: ErrorHandler?
    var listMovieStates: ((ListMovieStates) -> ())?
    var networkService: NetworkServiceProtocol
    var imageService: ImageServiceProtocol
    let keyChainService: KeyChainServiceProtocol
    var layoutHandler: VoidHandler?
    var listMovieProps: ListMovieStates = .initial {
        didSet {
            layoutHandler?()
        }
    }

    // MARK: - Initializers

    init(
        networkService: NetworkServiceProtocol,
        imageService: ImageServiceProtocol,
        keyChainService: KeyChainServiceProtocol
    ) {
        self.networkService = networkService
        self.imageService = imageService
        self.keyChainService = keyChainService
    }

    // MARK: - Public Methods

    func keyChainInfo() -> KeyChainServiceProtocol {
        keyChainService
    }

    func segmentControlAction(index: Int) {
        switch index {
        case 0:
            loadMovies(method: .upcomingMethod)
        case 1:
            loadMovies(method: .popularMethod)
        case 2:
            loadMovies(method: .topRatedMethod)
        default:
            break
        }
    }

    func fetchMovies() {
        listMovieStates?(.initial)
        loadMovies(method: .upcomingMethod)
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
                self.coreDataStack.saveContext(movies: movies.movies, moviesType: method)
                let movies = self.coreDataStack.getData(moviesType: method)
                self.listMovieProps = .success(movies)
            case let .failure(error):
                self.listMovieProps = .failure(error)
            }
        }
    }

    private func loadMovies(method: MethodType) {
        let movies = coreDataStack.getData(moviesType: method)
        if !movies.isEmpty {
            listMovieProps = .success(movies)
        } else {
            fetchMovies(method: method)
        }
    }
}
