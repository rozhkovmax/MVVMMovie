// AssemblyBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Сборщик экранов
final class AssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeListMovieModule() -> UIViewController {
        let networkService = NetworkService()
        let imageService = ImageService()
        let listMovieViewModel = ListMovieViewModel(networkService: networkService, imageService: imageService)
        let listMovieViewController = ListMovieViewController(listMovieViewModel: listMovieViewModel)
        return listMovieViewController
    }

    func makeDetailMovieModule(movie: Movie?) -> UIViewController {
        let imageService = ImageService()
        let detailMovieViewModel = DetailMovieViewModel(film: movie, imageService: imageService)
        let detailMovieViewController = DetailMovieViewController(detailMovieViewModel: detailMovieViewModel)
        return detailMovieViewController
    }
}
