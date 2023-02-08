// AssemblyBuilder.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

// Сборщик экранов
final class AssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeListMovieModule() -> UIViewController {
        let keyChainService = KeyChainService()
        let networkService = NetworkService(keyChainService: keyChainService)
        let imageService = ImageService()
        let listMovieViewModel = ListMovieViewModel(
            networkService: networkService,
            imageService: imageService,
            keyChainService: keyChainService
        )
        let listMovieViewController = ListMovieViewController(listMovieViewModel: listMovieViewModel)
        return listMovieViewController
    }

    func makeDetailMovieModule(movie: Movie?) -> UIViewController {
        let imageService = ImageService()
        let detailMovieViewModel = DetailMovieViewModel(
            film: movie,
            imageService: imageService
        )
        let detailMovieViewController = DetailMovieViewController(detailMovieViewModel: detailMovieViewModel)
        return detailMovieViewController
    }
}
