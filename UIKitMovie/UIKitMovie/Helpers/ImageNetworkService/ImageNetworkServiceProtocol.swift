// ImageNetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол получения изображений
protocol ImageNetworkServiceProtocol {
    // MARK: - Public Methods

    func fetchImage(imagePath: String, completion: @escaping (Result<Data, Error>) -> Void)
}
