// ListMovieViewModel.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Вью модель списка фильмов
final class ListMovieViewModel: ListMovieViewModelProtocol {
    // MARK: - Public Properties

    var errorAlert: ErrorHandler?
    var errorCoreDataAlert: AlertHandler?
    var listMovieStates: ((ListMovieStates) -> ())?
    var layoutHandler: VoidHandler?
    var methodType: MethodType = .popularMethod
    var listMovieProps: ListMovieStates = .initial {
        didSet {
            layoutHandler?()
        }
    }

    // MARK: - Private Properties

    private let coreDataService: CoreDataServiceProtocol
    private let networkService: NetworkServiceProtocol
    private let imageService: ImageServiceProtocol
    private let keyChainService: KeyChainServiceProtocol

    // MARK: - Initializers

    init(
        networkService: NetworkServiceProtocol,
        imageService: ImageServiceProtocol,
        keyChainService: KeyChainServiceProtocol,
        coreDataService: CoreDataServiceProtocol
    ) {
        self.networkService = networkService
        self.imageService = imageService
        self.keyChainService = keyChainService
        self.coreDataService = coreDataService
    }

    // MARK: - Public Methods

    func keyChainInfo() -> KeyChainServiceProtocol {
        keyChainService
    }

    func segmentControlAction(index: Int) {
        switch index {
        case 0:
            methodType = .upcomingMethod
        case 1:
            methodType = .popularMethod
        case 2:
            methodType = .topRatedMethod
        default:
            break
        }
        loadMovies(method: methodType)
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

    func loadMovies(method: MethodType) {
        let movies = coreDataService.getData(moviesType: method)
        if !movies.isEmpty {
            listMovieProps = .success(movies)
        } else {
            fetchMovies(method: method)
        }
    }

    // MARK: - Private Methods

    private func fetchMovies(method: MethodType) {
        networkService.fetchMovies(method: method) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.coreDataService.saveData(movies: movies.movies, moviesType: method)
                let movies = self.coreDataService.getData(moviesType: method)
                self.listMovieProps = .success(movies)
            case let .failure(error):
                self.listMovieProps = .failure(error)
            }
        }
    }
}
