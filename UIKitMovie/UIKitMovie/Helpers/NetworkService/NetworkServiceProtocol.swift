// NetworkServiceProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Протокол сетевого слоя
protocol NetworkServiceProtocol {
    // MARK: - Public Methods

    func fetchMovies(method: MethodType, completion: @escaping (Result<ResultsMovie, Error>) -> Void)
}