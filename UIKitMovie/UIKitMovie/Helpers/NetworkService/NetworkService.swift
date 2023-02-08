// NetworkService.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Сетевой сервис
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let baseURL = "https://api.themoviedb.org/3/movie/"
        static let APIKey = "api_key"
        static let languageKey = "language"
        static let languageValue = "ru-RU"
        static let pageKey = "page"
        static let pageValue = "1"
        static let APIKeyValue = "b6abe1b1835ab9f0603050760032a03a"
    }

    // MARK: - Public Methods

    func fetchMovies(method: MethodType, completion: @escaping (Result<ResultsMovie, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: Constants.baseURL + method.method) else { return }
        urlComponents.queryItems = [URLQueryItem(name: Constants.APIKey, value: Constants.APIKeyValue),
                                    URLQueryItem(name: Constants.languageKey, value: Constants.languageValue),
                                    URLQueryItem(name: Constants.pageKey, value: Constants.pageValue)]
        guard let url = urlComponents.url else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let movies = try JSONDecoder().decode(ResultsMovie.self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
