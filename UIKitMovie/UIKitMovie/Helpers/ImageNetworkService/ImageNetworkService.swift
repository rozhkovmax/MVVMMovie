// ImageNetworkService.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Сервис получения изображений
final class ImageNetworkService: ImageNetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let imageBaseUrlText = "https://image.tmdb.org/t/p/w500"
    }

    // MARK: - Public Methods

    func fetchImage(imagePath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlComponents = URLComponents(string: Constants.imageBaseUrlText) else { return }
        guard let imageURL = URL(string: "\(urlComponents)\(imagePath)") else { return }
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard let data = data else { return }
            completion(.success(data))
            if let error = error {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
