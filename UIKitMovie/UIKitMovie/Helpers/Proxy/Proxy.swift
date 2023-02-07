// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прокси
final class Proxy: ProxyProtocol {
    // MARK: - Public Properties

    let imageNetworkService: ImageNetworkServiceProtocol
    let fileManagerService: FileManagerServiceProtocol

    // MARK: - Initializator

    init(imageNetworkService: ImageNetworkServiceProtocol, fileManagerService: FileManagerServiceProtocol) {
        self.imageNetworkService = imageNetworkService
        self.fileManagerService = fileManagerService
    }

    // MARK: - Public Methods

    func loadImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let image = fileManagerService.getImageFromCache(url: url) else {
            imageNetworkService.fetchImage(imagePath: url) { result in
                switch result {
                case let .success(data):
                    self.fileManagerService.saveImageToCache(url: url, data: data)
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
            return
        }
        completion(.success(image))
    }
}
