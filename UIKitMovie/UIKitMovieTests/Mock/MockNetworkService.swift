// MockNetworkService.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

@testable import UIKitMovie

/// Мок сетевого сервиса
final class MockNetworkService: NetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockMovieJSONName = "MockMovie"
        static let mockMovieJSONType = "json"
    }

    // MARK: - Public Methods

    func fetchMovies(method: MethodType, completion: @escaping (Result<ResultsMovie, Error>) -> Void) {
        guard let jsonURL = Bundle.main.path(
            forResource: Constants.mockMovieJSONName,
            ofType: Constants.mockMovieJSONType
        )
        else { return }
        do {
            let fileURL = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: fileURL)
            let results = try JSONDecoder().decode(ResultsMovie.self, from: data)
            completion(.success(results))
        } catch {
            completion(.failure(error))
        }
    }
}
