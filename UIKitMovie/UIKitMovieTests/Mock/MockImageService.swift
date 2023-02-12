// MockImageService.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

@testable import UIKitMovie

/// Мок сервиса запроса изображения
final class MockImageService: ImageServiceProtocol {
    // MARK: - Public Methods
    
    func getImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            guard let data = url.data(using: .utf8) else { return }
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
}
