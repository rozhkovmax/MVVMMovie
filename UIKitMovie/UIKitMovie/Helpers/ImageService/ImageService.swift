// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сервис запроса изображения
final class ImageService: ImageServiceProtocol {
    // MARK: - Public Properties

    let imageNetworkService = ImageNetworkService()
    let fileManagerService = FileManagerService()

    // MARK: - Public Methods

    func getImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let proxy = Proxy(imageNetworkService: imageNetworkService, fileManagerService: fileManagerService)
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
