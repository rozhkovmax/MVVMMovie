// ImageService.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Сервис запроса изображения
final class ImageService: ImageServiceProtocol {
    // MARK: - Public Properties

    let imageNetworkService = ImageNetworkService()
    let fileService = FileService()

    // MARK: - Public Methods

    func getImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let proxy = Proxy(imageNetworkService: imageNetworkService, fileService: fileService)
        proxy.loadImage(url: url) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
