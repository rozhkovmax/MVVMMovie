// NetworkServiceProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Протокол сетевого слоя
protocol NetworkServiceProtocol {
    func fetchMovies(method: MethodType, completion: @escaping (Result<ResultsMovie, Error>) -> Void)
}
