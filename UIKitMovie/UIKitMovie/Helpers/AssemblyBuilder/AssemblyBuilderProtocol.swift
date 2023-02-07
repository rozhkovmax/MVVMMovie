// AssemblyBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Протокол сборщика экранов
protocol AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeListMovieModule() -> UIViewController
    func makeDetailMovieModule(movie: Movie?) -> UIViewController
}
