// AssemblyBuilderProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

// Протокол сборщика экранов
protocol AssemblyBuilderProtocol {
    func makeListMovieModule() -> UIViewController
    func makeDetailMovieModule(movie: MovieData?) -> UIViewController
}
