// AssemblyBuilder.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

// Сборщик экранов
final class AssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let coreDataModelName = "MovieDataModel"
    }

    // MARK: - Public Methods

    func makeListMovieModule() -> UIViewController {
        let coreDataService = CoreDataService(modelName: Constants.coreDataModelName)
        let keyChainService = KeyChainService()
        let networkService = NetworkService(keyChainService: keyChainService)
        let imageService = ImageService()
        let listMovieViewModel = ListMovieViewModel(
            networkService: networkService,
            imageService: imageService,
            keyChainService: keyChainService,
            coreDataService: coreDataService
        )
        let listMovieViewController = ListMovieViewController(listMovieViewModel: listMovieViewModel)
        return listMovieViewController
    }

    func makeDetailMovieModule(movie: MovieData?) -> UIViewController {
        let imageService = ImageService()
        let detailMovieViewModel = DetailMovieViewModel(
            film: movie,
            imageService: imageService
        )
        let detailMovieViewController = DetailMovieViewController(detailMovieViewModel: detailMovieViewModel)
        return detailMovieViewController
    }
}
