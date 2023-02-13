// MockImageNetworkService.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

@testable import UIKitMovie

/// Мок сервиса получения изображений
final class MockImageNetworkService: ImageNetworkServiceProtocol {
    // MARK: - Public Methods

    func fetchImage(imagePath: String, completion: @escaping (Result<Data, Error>) -> Void) {}
}
