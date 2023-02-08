// Proxy.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Прокси
final class Proxy: ProxyProtocol {
    // MARK: - Public Properties

    let imageNetworkService: ImageNetworkServiceProtocol
    let fileService: FileServiceProtocol

    // MARK: - Initializator

    init(imageNetworkService: ImageNetworkServiceProtocol, fileService: FileServiceProtocol) {
        self.imageNetworkService = imageNetworkService
        self.fileService = fileService
    }

    // MARK: - Public Methods

    func loadImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let image = fileService.getImageFromCache(url: url) else {
            imageNetworkService.fetchImage(imagePath: url) { result in
                switch result {
                case let .success(data):
                    self.fileService.saveImageToCache(url: url, data: data)
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
