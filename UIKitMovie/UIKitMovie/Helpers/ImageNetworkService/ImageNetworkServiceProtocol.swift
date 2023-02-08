// ImageNetworkServiceProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Протокол получения изображений
protocol ImageNetworkServiceProtocol {
    // MARK: - Public Methods

    func fetchImage(imagePath: String, completion: @escaping (Result<Data, Error>) -> Void)
}
